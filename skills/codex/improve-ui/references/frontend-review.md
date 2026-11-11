# Frontend review guide

Use this reference for frontend, PR, component, design-system, responsive, theme, creative, or accessibility reviews. Select the dimensions justified by the request and available evidence; do not treat the full list as mandatory for every review.

## Review frame

Identify:

- Purpose, audience, and primary user task.
- Reviewed scope: component, feature, flow, PR, or application surface.
- Current aesthetic direction and governing design evidence.
- Evidence actually inspected: source, rendered states, tests, Figma, Storybook, component library, tokens, or documentation.

Assess three quality pillars:

1. **Frictionless insight to action** — The next action is clear, the task path is efficient, primary and secondary actions have intentional hierarchy, navigation has clear entry and exit points, and the flow avoids dead ends.
2. **Quality craft** — The implementation uses the connected design system correctly, has coherent visual direction, handles responsive reflow and themes, and meets the requested accessibility depth.
3. **Trustworthy building** — Errors explain recovery, system state is legible, consequential actions communicate outcomes, and AI-generated content is disclosed when relevant.

The often-useful heuristic of completing a core task in roughly three interactions is a prompt for investigation, not a universal contract. Complex or safety-sensitive tasks may legitimately require more steps.

## Evidence and severity

For each issue include:

- Observation and affected user task.
- Evidence and its limits.
- Quality pillar or design-system rule affected.
- One actionable recommendation, naming an existing token/component/pattern when supported.
- Severity: **blocking** only when the task, release, accessibility baseline, or binding design contract fails; **major** for substantial friction or inconsistency; **minor** for bounded polish.

Label heuristic or aesthetic advice as a recommendation rather than a verified defect. Do not claim exact Figma parity, keyboard behavior, contrast, screen-reader behavior, reflow, or theme behavior without checking it.

## Context modifiers

### Platform scope

- **Web:** Check responsive breakpoints and fluid reflow, browser input modes, keyboard focus, hover/pointer assumptions, content extremes, zoom, themes, and PWA behavior when applicable.
- **Mobile app:** Check safe areas, orientation, touch targets and gestures, software keyboard behavior, native navigation, offline/loading transitions, system text scaling, and iOS/Android conventions relevant to the actual client.
- **Desktop app:** Check window resizing and minimum sizes, keyboard navigation and shortcuts, pointer states, native window conventions, density, and platform-specific menus or dialogs.
- **Both:** Trace shared design owners first, then verify where platform adaptations intentionally diverge. Do not force identical UI where native conventions require different behavior.

### PR or code review

Focus on changed behavior and regressions. Check component and token use, variants and states, responsive branches, focus/error/loading handling, and code-level accessibility risks. Cite precise locations and avoid commenting on unrelated legacy code.

### Design review

Focus on the end-to-end task, action hierarchy, navigation, progressive disclosure, consistency, and connected design-system patterns. Use rendered evidence for visual hierarchy or usability claims.

### Creative frontend review

Evaluate whether purpose and tone are clear; typography, palette, composition, motion, and atmosphere form one coherent direction; and implementation complexity matches the intended restraint or expressiveness. Avoid universal font bans or style prescriptions: judge whether choices fit this product and audience.

### Accessibility audit

Define the requested standard and test depth. When possible, cover keyboard operation, visible focus, semantic structure, accessible names, contrast, zoom/reflow, motion preferences, and relevant screen readers. Report code-only observations as risks until behavior is tested.

### Design-system compliance audit

Trace components and tokens to the system that actually governs the surface. Verify supported variants, states, spacing, typography, and theme behavior. Record intentional exceptions separately from drift.

## Recommended output

```markdown
## Frontend review: <surface>

### Context
- Purpose and user task:
- Scope:
- Design direction:
- Evidence inspected:
- Evidence unavailable:

### Summary
<Pass / Needs work / Blocked> — <one-line assessment>

### Pillars
| Pillar | Status | Evidence-based notes |
| --- | --- | --- |
| Frictionless | Pass / Attention / Blocking | ... |
| Quality craft | Pass / Attention / Blocking | ... |
| Trustworthy | Pass / Attention / Blocking | ... |

### Issues
#### Blocking
1. <observation, evidence, impact, correction>

#### Major
1. ...

#### Minor
1. ...

### Recommendations requiring validation
- <heuristic improvement and required validation>

### Validation performed
- <checks run and observable results>
```

Omit empty severity sections. A pass means the inspected evidence supports approval within the stated scope; it does not imply untested states passed.

## Pre-approval prompts

- Is the primary task and next action clear?
- Are connected system components, tokens, variants, and spacing used correctly?
- Are loading, empty, error, success, disabled, hover, focus, and selected states relevant and covered?
- Does the layout reflow at relevant widths and under content extremes?
- Do light, dark, high-contrast, and reduced-motion modes work when supported?
- Is keyboard and assistive-technology behavior verified to the requested depth?
- Are errors actionable and outcomes understandable?
- Does the visual direction fit the product rather than imitate a generic template?
- Have shared, web-only, and app-only corrections been separated when more than one client exists?

## Attribution

Adapted from Microsoft's `frontend-design-review` skill:
https://github.com/microsoft/skills/tree/main/.github/skills/frontend-design-review

The source skill credits its quality-pillar framework to @Quirinevwm and its creative frontend guidance to Anthropic's frontend-design skill. Microsoft publishes the repository under the MIT License.
