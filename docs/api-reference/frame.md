# 帧作用域与调试

管理 MGFX 绘制帧、矩形裁剪和调试叠层。所有坐标都相对于当前 active frame。

## 适用边界

- 在 `PANEL:Paint` 里使用 `StartPanel` / `EndPanel`。
- 在 `HUDPaint` 或屏幕空间 overlay 里使用 `StartScreen` / `EndScreen`。
- `PushClip` / `PopClip` 只做矩形 scissor，不是任意形状 mask。

## 本页 API

- [StartPanel](#startpanel) - 开始一个面板本地 MGFX 帧，并立即安装面板裁剪。
- [EndPanel](#endpanel) - 结束当前面板帧，回放已排队的文本/裁剪命令，并清理帧状态。
- [StartScreen](#startscreen) - 开始一个屏幕空间 MGFX 帧，通常用于 HUDPaint。
- [EndScreen](#endscreen) - 结束当前屏幕帧并刷新已排队的命令。
- [PushClip](#pushclip) - 压入一个相对于当前帧的矩形 scissor 裁剪。
- [PopClip](#popclip) - 弹出当前矩形裁剪，并恢复上一个 scissor 矩形。
- [DebugOverlay](#debugoverlay) - 绘制一个小型内部渲染统计叠层。

## 函数参考

## StartPanel

```lua
MGFX.StartPanel(panel, w, h)
```

开始一个面板本地 MGFX 帧，并立即安装面板裁剪。

#### 参数

| 参数 | 说明 |
| --- | --- |
| panel | VGUI 面板。它的 LocalToScreen(0, 0) 会成为帧原点。 |
| w, h | 可选帧尺寸。省略时 MGFX 会读取 panel:GetSize()。 |

#### 用法说明

- 在 PANEL:Paint 或其他面板本地绘制函数开头调用。
- 之后的绘制坐标是面板本地坐标，不是屏幕坐标。
- 始终在同一次绘制中配对调用 EndPanel。

#### 示例

```lua
function PANEL:Paint(w, h)
    MGFX.StartPanel(self, w, h)
    MGFX.RoundedBox(0, 0, w, h, 8, Color(20, 24, 32, 230))
    MGFX.EndPanel()
end
```

## EndPanel

```lua
MGFX.EndPanel()
```

结束当前面板帧，回放已排队的文本/裁剪命令，并清理帧状态。

#### 用法说明

- 形状和图像通常立即绘制；文本会在这里刷新。
- 在本帧所有 MGFX 面板绘制调用之后调用。

#### 示例

```lua
MGFX.StartPanel(self, w, h)
MGFX.Text("Ready", "DermaDefault", 12, 12, color_white)
MGFX.EndPanel()
```

## StartScreen

```lua
MGFX.StartScreen(w, h)
```

开始一个屏幕空间 MGFX 帧，通常用于 HUDPaint。

#### 参数

| 参数 | 说明 |
| --- | --- |
| w, h | 可选屏幕帧尺寸。默认使用 ScrW() 与 ScrH()。 |

#### 用法说明

- 坐标已经是屏幕空间，原点在屏幕左上角。
- 用于 HUD 图层，不用于面板 paint。

#### 示例

```lua
hook.Add("HUDPaint", "MyHud", function()
    MGFX.StartScreen()
    MGFX.Ring(ScrW() - 72, 72, 28, 5, Color(80, 210, 170))
    MGFX.EndScreen()
end)
```

## EndScreen

```lua
MGFX.EndScreen()
```

结束当前屏幕帧并刷新已排队的命令。

#### 用法说明

- 与 StartScreen 配对使用。
- 如果文本出现在形状后面，请在 EndScreen 前更晚地发出文本调用。

#### 示例

```lua
MGFX.StartScreen()
MGFX.Text("Wave 4", "DermaLarge", 24, 24, color_white)
MGFX.EndScreen()
```

## PushClip

```lua
MGFX.PushClip(x, y, w, h)
```

压入一个相对于当前帧的矩形 scissor 裁剪。

#### 参数

| 参数 | 说明 |
| --- | --- |
| x, y | 裁剪矩形原点，使用当前帧本地像素。 |
| w, h | 裁剪矩形尺寸。非正面积会变为空裁剪。 |

#### 用法说明

- 这只做矩形裁剪，不是形状遮罩栈。
- 嵌套裁剪会与父裁剪取交集。

#### 示例

```lua
MGFX.PushClip(12, 12, w - 24, h - 24)
MGFX.Image(0, 0, w, h, "materials/my/wide_image.png")
MGFX.PopClip()
```

## PopClip

```lua
MGFX.PopClip()
```

弹出当前矩形裁剪，并恢复上一个 scissor 矩形。

#### 用法说明

- 每次 PushClip 都应对应一次 PopClip。
- 裁剪栈不平衡会影响同一帧后续绘制。

#### 示例

```lua
MGFX.PushClip(x, y, w, h)
-- clipped MGFX draws here
MGFX.PopClip()
```

## DebugOverlay

```lua
MGFX.DebugOverlay(x, y)
```

绘制一个小型内部渲染统计叠层。

#### 参数

| 参数 | 说明 |
| --- | --- |
| x, y | 可选叠层位置。默认 16, 16。 |

#### 用法说明

- 开发时用于查看 draw count、fallback count 和文本统计。
- 它使用普通 GMod 文本绘制，不适合作为最终 UI。

#### 示例

```lua
MGFX.StartScreen()
MGFX.DebugOverlay(16, 96)
MGFX.EndScreen()
```

[返回详细 API 入口](./index)
