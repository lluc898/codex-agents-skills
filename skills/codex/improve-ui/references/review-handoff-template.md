# UI review development handoff

Create one self-contained Markdown file using this structure. Replace every placeholder, remove empty optional sections, and keep all evidence and instructions specific to the reviewed repository.

````markdown
# UI review and implementation handoff

Reviewed on: `<YYYY-MM-DD>`
Written against: `<commit SHA or unavailable>`
Product classification: `<Web | App | Both | Indeterminate>`
Platforms and stack: `<exact platforms/frameworks>`

## Objective

<What product surface was reviewed, the user journeys it supports, and the outcome this handoff should achieve.>

## Review scope

### Reviewed
- `<application, route/screen, state, viewport/device, theme>`

### Not reviewed
- `<surface or verification gap and why>`

### Evidence inspected
- `<source path, symbol, rendered state, screenshot, design document, component library, or command/result>`

## Product and design system

- Product type:
- Shared design owners:
- Web-specific owners:
- App-specific owners:
- Governing design sources:
- Existing tokens/components/variants to reuse:
- Explicit exceptions:

## Executive summary

<Current quality, highest-impact themes, and recommended implementation order.>

| Priority | Verified defects | Implementation risks | Design recommendations |
| --- | ---: | ---: | ---: |
| P0 | 0 | 0 | 0 |
| P1 | 0 | 0 | 0 |
| P2 | 0 | 0 | 0 |
| P3 | 0 | 0 | 0 |

## Corrections

### UI-001 — `<short outcome-oriented title>`

- **Classification:** `<Verified defect | Implementation risk | Design recommendation>`
- **Priority:** `<P0 | P1 | P2 | P3>`
- **Platform:** `<Shared | Web | App: iOS/Android/Desktop/etc.>`
- **Surface and state:** `<route/screen/component/state/viewport>`
- **User task affected:** `<task>`
- **Observation:** `<what is wrong or risky>`
- **Evidence:** `<exact paths/symbols/lines when stable/rendered evidence>`
- **Impact:** `<user and system consequence>`
- **Root cause:** `<owner, token, component, variant, layout, or missing state>`
- **Required correction:** `<one deterministic implementation direction>`
- **Reuse:** `<existing tokens/components/variants/exemplars>`
- **Affected files and consumers:** `<paths/components/screens; distinguish direct edits from inherited effects>`
- **Preserve:** `<valid behavior, content, identity, and platform conventions>`
- **Acceptance criteria:**
  - [ ] `<observable result>`
  - [ ] `<relevant state/platform/result>`
- **Validation:** `<exact route, viewport/device, input method, theme, state, and command/check>`
- **Dependencies:** `<other correction IDs or none>`
- **Uncertainty:** `<none, or fact that must be confirmed before implementation>`
- **Stop condition:** `<condition requiring clarification instead of invention>`

<Repeat for every supported correction. Merge items with the same root correction.>

## Cross-platform implementation notes

### Shared
- `<changes inherited by web and app>`

### Web
- `<browser, responsive, pointer/keyboard, PWA, or web-only considerations>`

### App
- `<mobile/desktop, safe-area, orientation, touch, native navigation, platform convention, or app-only considerations>`

## Implementation sequence

1. `<correction IDs, rationale, and prerequisites>`
2. `<next group>`

## Validation matrix

| Platform | Surface | Viewport/device | Theme | Input/AT | State | Expected result |
| --- | --- | --- | --- | --- | --- | --- |
| `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` | `<...>` |

## Repository checks

- `<exact existing lint/typecheck/test/build command>` → `<expected result>`

Do not invent commands. If unavailable, state what must be identified by the development agent.

## Completion evidence

The development agent must update this section after implementation:

- [ ] Each correction marked complete or explicitly deferred with reason.
- [ ] Validation matrix executed with results.
- [ ] Repository checks executed with results.
- [ ] Screenshots or recordings added where visual verification is required and supported.
- [ ] Deviations from this handoff documented with evidence.

## Development-agent prompt

```text
Work in this repository and implement the complete UI review handoff at `design-plans/<exact-file-name>.md`.

Read the entire handoff before editing. Inspect the current repository state and verify that every cited path, owner, component, token, and assumption is still valid. Then implement every in-scope correction in the documented priority and dependency order, including shared, web-specific, and app-specific work where applicable.

Preserve valid behavior, content, accessibility, platform conventions, and the product's existing identity. Reuse the named design-system owners and do not create parallel tokens or components unless the handoff explicitly justifies them. Do not silently invent product intent: if a stop condition or stale assumption is encountered, document the evidence and ask for clarification.

Run the handoff's validation matrix and repository checks. Update the handoff's Completion evidence section with completed items, commands and results, visual verification performed, and any evidence-backed deviations. Finish with a concise summary of files changed, corrections completed, validation results, and remaining blockers.
```
````

If no corrections survive, omit the correction and implementation-sequence sections, retain the review evidence and limitations, and make the development-agent prompt state that no implementation is currently authorized because no supported correction was identified.
