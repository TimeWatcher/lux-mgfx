# 文本 API

字体别名、文本样式、测量、预热、原生文本路径和 shader text effects。

## 适用边界

- 普通 label、scoreboard、表格、日志和聊天优先用原生 GMod text。
- 只有需要渐变字面、描边、glow、shadow、surface polish 等 shader 特效时才进入 MGFX text composer。
- 稳定的特效文本可以用 `PrewarmText` 提前烘焙。

## 本页 API

- [RegisterTextFont](#registertextfont) - 注册 MGFX 文本字体别名。
- [DefineTextStyle](#definetextstyle) - 存储可复用文本样式记录。
- [GetTextStyle](#gettextstyle) - 获取之前定义的文本样式。
- [ResolveTextStyle](#resolvetextstyle) - 规范化文本样式表以便复用。
- [MeasureText](#measuretext) - 测量单段文本。
- [MeasureTextBox](#measuretextbox) - 为固定宽度文本框测量换行或省略后的文本。
- [PrewarmText](#prewarmtext) - 在首次绘制前把稳定文本烘焙进合成图集。
- [Text](#text) - 简单文本绘制 helper。
- [TextEx](#textex) - 带合成特效的高级文本绘制。
- [TextBox](#textbox) - 简单文本框绘制 helper。
- [TextBoxEx](#textboxex) - 支持换行、对齐和合成特效的高级文本框。

## 函数参考

## RegisterTextFont

```lua
MGFX.RegisterTextFont(name, spec)
```

注册 MGFX 文本字体别名。

#### 参数

| 参数 | 说明 |
| --- | --- |
| name | MGFX 文本调用使用的公共字体别名。 |
| spec.face | 原生字体 face 名称。 |
| spec.size, weight, lineHeight | 字体度量和变体提示。 |

#### 用法说明

- 绘制需要 shader 文本特效的文本前先注册字体。
- TextBox 需要稳定垂直节奏时请包含 lineHeight。

#### 返回值

根据渲染器注册是否成功返回 true/false。

#### 字体 spec 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `face / font`<br>系统字体名称。 | `nil` | 创建 MGFX 原生合成字体别名。 |
| `sourceFont / nativeFont`<br>已有 GMod 字体名称。 | `fontName` | 省略 face 时使用已有 surface 字体。 |
| `size`<br>数字。 | `16` | MGFX 过采样前的字体大小。 |
| `weight`<br>100..1200，或 1..10 快捷值。 | `500 / 400 for Noto Sans SC` | 原生字体字重。 |
| `italic`<br>布尔值。 | `false` | 创建斜体原生字体变体。 |
| `lineHeight / lineheight`<br>数字。 | `measured Hg height` | 此别名的默认行高。 |
| `tracking / letterSpacing`<br>数字。 | `0` | 默认字符间距。 |
| `syntheticWeight / allowSyntheticWeight`<br>布尔值。 | `false` | 允许样式侧合成字重调整。 |

#### 示例

```lua
MGFX.RegisterTextFont("ScoreTitle", {
    face = "Noto Sans SC",
    size = 28,
    weight = 700,
    lineHeight = 32,
})
```

## DefineTextStyle

```lua
MGFX.DefineTextStyle(name, style)
```

存储可复用文本样式记录。

#### 参数

| 参数 | 说明 |
| --- | --- |
| name | 样式名称。 |
| style | 文本样式表：fill、stroke、glow、shadow、tracking、lineHeight 等。 |

#### 用法说明

- 样式是显式值；MGFX 没有公共样式栈。
- 用于重复的 scoreboard 标签和标题。

#### 文本 style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `extends / base`<br>样式名、样式表，或样式数组。 | `nil` | 继承已定义文本样式。 |
| `fill / color`<br>Color 或 MGFX 渐变记录。 | `call color or white` | 文字面填充。 |
| `alignX / align / alignY / valign`<br>TEXT_ALIGN_* 常量，或 left/center/right/top/bottom 字符串。 | `call args / top-left` | 文本锚点或文本框对齐。 |
| `lineHeight`<br>数字。 | `font alias or measured height` | 多行文本和文本框的行距。 |
| `tracking / letterSpacing`<br>数字。 | `font alias tracking` | 字符间额外间距。 |
| `shadow`<br>true、数字，或 {x/offsetX, y/offsetY, blur/radius, color/tint, strength}。 | `nil` | 合成文本投影。 |
| `stroke / outline`<br>true、数字，或 {width/size, color/tint, samples, softness}。 | `nil` | 文本描边。 |
| `glow`<br>true、数字，或 {size, color/tint, opacity, softness}。 | `nil` | 文本发光 pass。 |
| `bold / thin / weightAdjust`<br>布尔快捷值，或 -2 到 2 的数字。 | `0` | 合成边缘字重调整。 |
| `italic`<br>布尔值。 | `false` | 可能时请求斜体原生字体变体。 |

#### 示例

```lua
MGFX.DefineTextStyle("ScoreGlow", {
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(255, 255, 255), Color(130, 210, 255)),
    glow = {size = 5, color = Color(80, 170, 255, 110)},
})
```

## GetTextStyle

```lua
MGFX.GetTextStyle(name)
```

获取之前定义的文本样式。

#### 参数

| 参数 | 说明 |
| --- | --- |
| name | 传给 DefineTextStyle 的样式名。 |

#### 用法说明

- 把返回的样式传给 TextEx 或 TextBoxEx。
- 样式不存在或文本渲染器不可用时返回 nil。

#### 返回值

文本样式表或 nil。

#### 示例

```lua
local titleStyle = MGFX.GetTextStyle("ScoreGlow")
MGFX.TextEx("ROUND 4", "ScoreTitle", x, y, nil, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, titleStyle)
```

## ResolveTextStyle

```lua
MGFX.ResolveTextStyle(style)
```

规范化文本样式表以便复用。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style | 原始文本样式表，或已经解析过的样式。 |

#### 用法说明

- 当你构建一次样式并传给多个文本调用时很有用。
- 已解析样式会原样返回。

#### 返回值

解析后的样式表。

#### 文本 style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `extends / base`<br>样式名、样式表，或样式数组。 | `nil` | 继承已定义文本样式。 |
| `fill / color`<br>Color 或 MGFX 渐变记录。 | `call color or white` | 文字面填充。 |
| `alignX / align / alignY / valign`<br>TEXT_ALIGN_* 常量，或 left/center/right/top/bottom 字符串。 | `call args / top-left` | 文本锚点或文本框对齐。 |
| `lineHeight`<br>数字。 | `font alias or measured height` | 多行文本和文本框的行距。 |
| `tracking / letterSpacing`<br>数字。 | `font alias tracking` | 字符间额外间距。 |
| `shadow`<br>true、数字，或 {x/offsetX, y/offsetY, blur/radius, color/tint, strength}。 | `nil` | 合成文本投影。 |
| `stroke / outline`<br>true、数字，或 {width/size, color/tint, samples, softness}。 | `nil` | 文本描边。 |
| `glow`<br>true、数字，或 {size, color/tint, opacity, softness}。 | `nil` | 文本发光 pass。 |
| `bold / thin / weightAdjust`<br>布尔快捷值，或 -2 到 2 的数字。 | `0` | 合成边缘字重调整。 |
| `italic`<br>布尔值。 | `false` | 可能时请求斜体原生字体变体。 |

#### 示例

```lua
local rowStyle = MGFX.ResolveTextStyle({
    fill = Color(230, 240, 255),
    shadow = {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 120)},
})
```

## MeasureText

```lua
MGFX.MeasureText(text, font)
```

测量单段文本。

#### 参数

| 参数 | 说明 |
| --- | --- |
| text | 文本值，按 tostring 语义转换。 |
| font | 字体别名或原生字体名。 |

#### 用法说明

- 用于定位标签或预留稳定单元格宽度。
- 换行或省略文本框请使用 MeasureTextBox。

#### 返回值

width, height。

#### 示例

```lua
local tw, th = MGFX.MeasureText(playerName, "ScoreRow")
MGFX.Text(playerName, "ScoreRow", x + w - tw, y, color_white)
```

## MeasureTextBox

```lua
MGFX.MeasureTextBox(text, font, w, style)
```

为固定宽度文本框测量换行或省略后的文本。

#### 参数

| 参数 | 说明 |
| --- | --- |
| w | 可用文本框宽度。 |
| style | 文本框样式，包括换行和行高选项。 |

#### 用法说明

- 在密集行中绘制变长标签前使用。
- 回退路径返回单行测量。

#### 返回值

width, height, lines。

#### 文本 style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `extends / base`<br>样式名、样式表，或样式数组。 | `nil` | 继承已定义文本样式。 |
| `fill / color`<br>Color 或 MGFX 渐变记录。 | `call color or white` | 文字面填充。 |
| `alignX / align / alignY / valign`<br>TEXT_ALIGN_* 常量，或 left/center/right/top/bottom 字符串。 | `call args / top-left` | 文本锚点或文本框对齐。 |
| `lineHeight`<br>数字。 | `font alias or measured height` | 多行文本和文本框的行距。 |
| `tracking / letterSpacing`<br>数字。 | `font alias tracking` | 字符间额外间距。 |
| `shadow`<br>true、数字，或 {x/offsetX, y/offsetY, blur/radius, color/tint, strength}。 | `nil` | 合成文本投影。 |
| `stroke / outline`<br>true、数字，或 {width/size, color/tint, samples, softness}。 | `nil` | 文本描边。 |
| `glow`<br>true、数字，或 {size, color/tint, opacity, softness}。 | `nil` | 文本发光 pass。 |
| `bold / thin / weightAdjust`<br>布尔快捷值，或 -2 到 2 的数字。 | `0` | 合成边缘字重调整。 |
| `italic`<br>布尔值。 | `false` | 可能时请求斜体原生字体变体。 |

#### 文本框字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `overflow`<br>"ellipsis" 或省略。 | `wrap` | 省略表示按字符换行。ellipsis 返回一行缩略文本。 |
| `alignX / align`<br>left、center、right，或 TEXT_ALIGN_*。 | `left` | 文本框内每行的水平位置。 |
| `alignY / valign`<br>top、center/middle、bottom，或 TEXT_ALIGN_*。 | `top` | 换行文本块的垂直位置。 |

#### 示例

```lua
local tw, th = MGFX.MeasureTextBox(description, "ScoreSmall", 220, {wrap = true, lineHeight = 18})
```

## PrewarmText

```lua
MGFX.PrewarmText(text, font, style)
```

在首次绘制前把稳定文本烘焙进合成图集。

#### 参数

| 参数 | 说明 |
| --- | --- |
| text, font | 要预热的文本段。 |
| style | 可选文本样式。 |

#### 用法说明

- 最适合稳定标题、标签、表格列名和重复 scoreboard 文本。
- 不要预热高度唯一且大量变化的值。

#### 文本 style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `extends / base`<br>样式名、样式表，或样式数组。 | `nil` | 继承已定义文本样式。 |
| `fill / color`<br>Color 或 MGFX 渐变记录。 | `call color or white` | 文字面填充。 |
| `alignX / align / alignY / valign`<br>TEXT_ALIGN_* 常量，或 left/center/right/top/bottom 字符串。 | `call args / top-left` | 文本锚点或文本框对齐。 |
| `lineHeight`<br>数字。 | `font alias or measured height` | 多行文本和文本框的行距。 |
| `tracking / letterSpacing`<br>数字。 | `font alias tracking` | 字符间额外间距。 |
| `shadow`<br>true、数字，或 {x/offsetX, y/offsetY, blur/radius, color/tint, strength}。 | `nil` | 合成文本投影。 |
| `stroke / outline`<br>true、数字，或 {width/size, color/tint, samples, softness}。 | `nil` | 文本描边。 |
| `glow`<br>true、数字，或 {size, color/tint, opacity, softness}。 | `nil` | 文本发光 pass。 |
| `bold / thin / weightAdjust`<br>布尔快捷值，或 -2 到 2 的数字。 | `0` | 合成边缘字重调整。 |
| `italic`<br>布尔值。 | `false` | 可能时请求斜体原生字体变体。 |

#### 示例

```lua
MGFX.PrewarmText("SCORE", "ScoreTitle", MGFX.GetTextStyle("ScoreGlow"))
```

## Text

```lua
MGFX.Text(text, font, x, y, color, ax, ay)
```

简单文本绘制 helper。

#### 参数

| 参数 | 说明 |
| --- | --- |
| color | 字面颜色。 |
| ax, ay | GMod 文本对齐常量。 |

#### 用法说明

- 在 MGFX 帧内，文本会排队并在 EndPanel/EndScreen 刷新。
- 需要渐变字面、描边、发光、阴影、字距或行高控制时使用 TextEx。

#### 示例

```lua
MGFX.Text("READY", "DermaLarge", x, y, color_white, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
```

## TextEx

```lua
MGFX.TextEx(text, font, x, y, color, ax, ay, style)
```

带合成特效的高级文本绘制。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.fill | Color 或 MGFX 渐变字面绘制。 |
| style.stroke | 描边表，含 width、color、softness。 |
| style.glow / shadow | 文本发光和阴影特效。 |
| style.tracking / lineHeight | 排版间距控制。 |

#### 用法说明

- 仍接受 color，但 style.fill 是高级字面绘制槽位。
- 普通文本保持 GMod 原生绘制。shader 特效文本会按整段烘焙，并从图集里合成绘制。

#### 文本 style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `extends / base`<br>样式名、样式表，或样式数组。 | `nil` | 继承已定义文本样式。 |
| `fill / color`<br>Color 或 MGFX 渐变记录。 | `call color or white` | 文字面填充。 |
| `alignX / align / alignY / valign`<br>TEXT_ALIGN_* 常量，或 left/center/right/top/bottom 字符串。 | `call args / top-left` | 文本锚点或文本框对齐。 |
| `lineHeight`<br>数字。 | `font alias or measured height` | 多行文本和文本框的行距。 |
| `tracking / letterSpacing`<br>数字。 | `font alias tracking` | 字符间额外间距。 |
| `shadow`<br>true、数字，或 {x/offsetX, y/offsetY, blur/radius, color/tint, strength}。 | `nil` | 合成文本投影。 |
| `stroke / outline`<br>true、数字，或 {width/size, color/tint, samples, softness}。 | `nil` | 文本描边。 |
| `glow`<br>true、数字，或 {size, color/tint, opacity, softness}。 | `nil` | 文本发光 pass。 |
| `bold / thin / weightAdjust`<br>布尔快捷值，或 -2 到 2 的数字。 | `0` | 合成边缘字重调整。 |
| `italic`<br>布尔值。 | `false` | 可能时请求斜体原生字体变体。 |

#### 示例

```lua
MGFX.TextEx(value, "ScoreStat", x, y, nil, TEXT_ALIGN_RIGHT, TEXT_ALIGN_TOP, {
    fill = MGFX.LinearGradient(0, 0, 1, 0, Color(255, 255, 255), Color(130, 210, 255)),
    glow = {size = 4, color = Color(80, 170, 255, 110)},
})
```

## TextBox

```lua
MGFX.TextBox(text, font, x, y, w, h, color, alignX, alignY)
```

简单文本框绘制 helper。

#### 参数

| 参数 | 说明 |
| --- | --- |
| w, h | 文本框边界。 |
| color | 文本颜色。 |
| alignX, alignY | 水平和垂直对齐常量。 |

#### 用法说明

- 用于固定矩形中的普通对齐文本。
- 需要换行、省略、行高和特效时使用 TextBoxEx。

#### 示例

```lua
MGFX.TextBox(playerName, "ScoreRow", x, y, 180, 24, color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
```

## TextBoxEx

```lua
MGFX.TextBoxEx(text, font, x, y, w, h, style)
```

支持换行、对齐和合成特效的高级文本框。

#### 参数

| 参数 | 说明 |
| --- | --- |
| style.fill / color | 文本字面绘制。 |
| style.alignX / alignY | 文本框对齐。 |
| style.lineHeight | 行高覆盖。 |
| style.wrap / ellipsis | 受支持时的文本布局行为。 |
| style.stroke, glow, shadow | 合成特效。 |

#### 用法说明

- TextBoxEx 会在活动 MGFX 帧内排队文本框命令。
- 布局需要先得到精确测量时使用 MeasureTextBox。

#### 文本 style 字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `extends / base`<br>样式名、样式表，或样式数组。 | `nil` | 继承已定义文本样式。 |
| `fill / color`<br>Color 或 MGFX 渐变记录。 | `call color or white` | 文字面填充。 |
| `alignX / align / alignY / valign`<br>TEXT_ALIGN_* 常量，或 left/center/right/top/bottom 字符串。 | `call args / top-left` | 文本锚点或文本框对齐。 |
| `lineHeight`<br>数字。 | `font alias or measured height` | 多行文本和文本框的行距。 |
| `tracking / letterSpacing`<br>数字。 | `font alias tracking` | 字符间额外间距。 |
| `shadow`<br>true、数字，或 {x/offsetX, y/offsetY, blur/radius, color/tint, strength}。 | `nil` | 合成文本投影。 |
| `stroke / outline`<br>true、数字，或 {width/size, color/tint, samples, softness}。 | `nil` | 文本描边。 |
| `glow`<br>true、数字，或 {size, color/tint, opacity, softness}。 | `nil` | 文本发光 pass。 |
| `bold / thin / weightAdjust`<br>布尔快捷值，或 -2 到 2 的数字。 | `0` | 合成边缘字重调整。 |
| `italic`<br>布尔值。 | `false` | 可能时请求斜体原生字体变体。 |

#### 文本框字段

| 字段 / 可接受值 | 默认值 | 作用 |
| --- | --- | --- |
| `overflow`<br>"ellipsis" 或省略。 | `wrap` | 省略表示按字符换行。ellipsis 返回一行缩略文本。 |
| `alignX / align`<br>left、center、right，或 TEXT_ALIGN_*。 | `left` | 文本框内每行的水平位置。 |
| `alignY / valign`<br>top、center/middle、bottom，或 TEXT_ALIGN_*。 | `top` | 换行文本块的垂直位置。 |

#### 示例

```lua
MGFX.TextBoxEx(description, "ScoreSmall", x, y, w, 42, {
    fill = Color(220, 230, 245),
    alignX = TEXT_ALIGN_LEFT,
    alignY = TEXT_ALIGN_TOP,
    lineHeight = 18,
    shadow = {x = 0, y = 1, blur = 2, color = Color(0, 0, 0, 140)},
})
```

[返回详细 API 入口](./index)
