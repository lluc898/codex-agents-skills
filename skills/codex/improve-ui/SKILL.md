---
name: improve-ui
description: Review the design of an existing web product, app, or both; detect the platform scope; inspect the relevant UI, UX, design-system, responsive, theme, and accessibility evidence; and always create one complete Markdown handoff plus a ready-to-use prompt for a development agent. Use for UI/design reviews and implementation handoffs. Do not use for backend-only, infrastructure, database, or non-UI business-logic work.
---

# Improve UI

Review an existing product interface and leave a development agent everything needed to apply every supported correction. Preserve the product's identity and distinguish verified issues from recommendations that still need visual or product validation.

## Required outcome

Every invocation completes this workflow unless the user explicitly narrows it:

1. Detect whether the reviewed product is **web**, **app**, or **both**.
2. Review the relevant interface comprehensively.
3. Create exactly one self-contained Markdown handoff under `design-plans/` containing all supported corrections in scope.
4. End the user-facing response with a copy-ready prompt that tells the development agent to execute that handoff.

Do not stop after listing findings, ask the user to select findings, cap the result to a fixed number, or leave the handoff for a later turn.

## Safety and write boundary

- The review is read-only on product source. Do not implement corrections, install dependencies, run formatters, commit, push, or edit design documentation.
- The only allowed repository write is the final handoff under `design-plans/`.
- If the user separately and explicitly asks this skill to implement, finish the review and handoff first; source edits require that additional authorization and are not implied by invoking the skill.
- Preserve unrelated user changes and existing handoff documents.

## 1. Detect product type and scope

Inspect repository structure, manifests, runtime entry points, route/navigation definitions, and build configuration before reviewing components.

Classify the reviewed product as:

- **Web** — browser-rendered product, including responsive websites and PWAs without a distinct native runtime.
- **App** — mobile or desktop application; record the actual platform and stack, such as iOS, Android, React Native, Expo, Flutter, Electron, Tauri, or native desktop.
- **Both** — the repository contains connected web and app clients in the user's product scope. Identify shared UI/design owners and platform-specific surfaces.
- **Indeterminate** — evidence is insufficient. State what is missing; do not guess.

A PWA alone is web. A native wrapper or separately deployable native/desktop client makes app scope relevant. Do not treat demos, Storybook, generated previews, legacy clients, or unrelated packages as product surfaces unless they participate in the current product.

If the repository contains both web and app, review both when they represent the same product and the request is broad. Separate shared corrections from web-only and app-only corrections. If scope is too large for a reliable review, cover the primary user journeys on every in-scope platform and list exactly what remains unreviewed in the handoff.

## 2. Reconstruct the product's design system

Start from deployable entry points and primary user journeys. Trace routes or navigation through layouts, screens, compositions, shared components, variants, tokens, themes, styles, platform adapters, and user-facing states.

Check repository guidance, `DESIGN.md`, current surface-local documentation, Figma evidence supplied or connected by the user, Storybook/component libraries, screenshots, and running UI when available. A source governs a surface only when imports, props, resolved configuration, inheritance, loaded artifacts, or rendered evidence prove the connection.

Record:

- Product type and technology.
- Audited applications, routes, screens, flows, and viewports.
- Shared and platform-specific design owners.
- Design sources and documented decisions.
- Existing tokens, components, variants, and exemplars to reuse.
- Explicit exceptions and unreviewed scope.

Prefer existing owners. Do not propose a new token or shared primitive merely because code repeats.

## 3. Review the interface

Read [references/frontend-review.md](references/frontend-review.md). Apply every dimension relevant to the detected platform and available evidence, including:

- Primary tasks, navigation, action hierarchy, discoverability, feedback, errors, and empty/loading/success states.
- Visual hierarchy, typography, color, spacing, density, iconography, composition, motion, and coherence with the product identity.
- Design-system and token compliance, component variants, duplication, and platform consistency.
- Responsive/reflow behavior, content extremes, orientation, safe areas, input methods, themes, and reduced motion where applicable.
- Accessibility risks and verified behavior at the depth supported by the available tools and request.

Use rendered evidence for claims about appearance, hierarchy, usability, contrast, reflow, touch behavior, or interaction whenever possible. If only source is available, report code-level risks and mark the required visual/device validation. Never imply that a platform, route, state, viewport, browser, device, theme, Figma file, or assistive technology was checked when it was not.

### Finding quality gate

Include a correction only when the handoff can state:

- The direct observation or verified risk.
- The affected platform, route/screen, state, and user task.
- Evidence with exact paths, symbols, lines when stable, or rendered states.
- User or system impact.
- One implementation direction supported by repository evidence or clearly labeled design judgment.
- Affected owners and consumers.
- Acceptance criteria and validation steps.

Classify each item as:

- **Verified defect** — current evidence proves a contradiction, failure, or binding design-system deviation.
- **Implementation risk** — source indicates a likely problem that still requires rendered or device verification.
- **Design recommendation** — expert judgment that improves the experience but is not a violated contract.

Prioritize as P0/blocking, P1/major, P2/moderate, or P3/polish based on user impact, reach, release risk, and effort. Do not inflate subjective polish into a blocker. Include all items that survive the quality gate; merge symptoms that share one root correction.

## 4. Create the development handoff

Read [references/review-handoff-template.md](references/review-handoff-template.md) before writing.

Create `design-plans/` if it does not exist. Write exactly one file using a stable, descriptive name:

```text
design-plans/ui-review-<web|app|web-and-app>-<YYYY-MM-DD>.md
```

If that filename exists, reconcile and update it when it covers the same product and review; otherwise add a short meaningful suffix instead of overwriting unrelated work.

The handoff must be executable without access to this conversation. Include all supported corrections, implementation order, exact reuse targets, affected files/components where determinable, per-platform differences, acceptance criteria, validation matrix, uncertainties, stop conditions, and a development-agent prompt. Do not include vague advice such as "improve spacing" without the exact target, intended relationship, and verification.

When no correction survives the quality gate, still create the handoff. Document the reviewed scope, evidence, checks, limitations, and that no supported corrections were found.

## 5. Final response

Return:

1. Product classification: web, app, both, or indeterminate.
2. Concise review summary and count by priority/type.
3. Clickable path to the generated Markdown handoff.
4. What was not visually or technically verified.
5. A fenced `text` block containing the exact development-agent prompt from the handoff, ready to copy.

Do not paste the entire handoff into the response. The prompt must identify the handoff by repository-relative path, require the agent to read it fully before editing, implement every in-scope correction in priority/dependency order, preserve valid behavior and product identity, validate the specified matrix, update the handoff with completion evidence, and report deviations or blockers rather than inventing requirements.

## Attribution

This workflow adapts `improve-ui` from https://github.com/ibelick/ui-skills and `frontend-design-review` from https://github.com/microsoft/skills (MIT), including the quality pillars credited there to @Quirinevwm and creative frontend guidance credited there to Anthropic's frontend-design skill.
