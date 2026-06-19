# Removed Batching Coverage Notes

This page is historical. Runtime shape batching has been removed.

The old coverage table should not be used as the current feature matrix. Current shape rendering is immediate shader/fallback rendering. See:

- [API Overview](./API)
- [API Reference](./api-reference/)
- [Performance Model](./PERFORMANCE)

When adding a feature, document the immediate path and fallback behavior instead of extending the old batching coverage model.
