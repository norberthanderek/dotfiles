# Hermes

The active Hermes configuration remains managed locally by Hermes in `~/.hermes/config.yaml`.

## Configuration

Apply these values manually with:

```text
hermes config edit
```

```yaml
model:
  default: openai/gpt-5.6-sol
  provider: openrouter

provider_routing:
  require_parameters: true
  data_collection: deny

agent:
  max_turns: 100
  reasoning_effort: high
  coding_instructions: >-
    Keep planning, architecture, tradeoffs, ambiguity resolution, and final integration in the parent.
    Delegate well-scoped execution work after the approach, constraints, and success criteria are clear.
  verify_on_stop: auto
  max_verify_nudges: 2

delegation:
  provider: openrouter
  model: z-ai/glm-5.3-flash
  reasoning_effort: high
  max_iterations: 50
  max_concurrent_children: 2
  max_spawn_depth: 1
  fallback_providers:
    - provider: openrouter
      model: deepseek/deepseek-v4.1-flash

auxiliary:
  compression:
    provider: openrouter
    model: z-ai/glm-5.3-flash
    reasoning_effort: low

display:
  show_cost: true
```

## Validation

After applying the configuration, validate it with:

```text
hermes config check
```

To inspect the effective configuration:

```text
hermes config
```
