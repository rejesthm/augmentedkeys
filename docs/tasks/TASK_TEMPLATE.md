# Task title

Use a short outcome-oriented title.

## Objective

State one verifiable outcome and the milestone or decision it serves.

## Why

Explain the user, reliability, evidence, or risk need. Do not use a planned capability as proof that the task is necessary.

## Scope

List the exact work authorized, including platforms, paths, interfaces, and evidence records.

## Explicit non-goals

List adjacent work and claims that remain out of scope.

## Research dependencies

Link accepted research and unresolved questions. A high-risk architecture decision must include an approved technical spike and benchmark plan and must produce or update an ADR before implementation can be approved. If the required evidence is unavailable, mark the task blocked rather than choosing an architecture by assumption.

## Files/modules affected

List expected paths and ownership boundaries. Identify protected paths and required approvals before editing.

## Acceptance criteria

Write objective, observable criteria. Separate functional behavior, failure behavior, performance budgets, accessibility, licensing, platform coverage, and documentation where relevant.

## Verification commands and expected evidence

List exact commands or reproducible procedures, the expected exit/result, required evidence fields, artifact locations, physical-device coverage, and reviewer. Do not record a command as passing until it has run against the named commit.

## Risks

Describe technical, real-time, platform, lifecycle, licensing, product, security, and evidence risks that apply. State the condition that requires stopping for owner direction.

## Rollback strategy

Describe how to return safely to the prior verified state without deleting unrelated work or evidence. Include data or migration recovery when relevant.

## Required reviewer

Name the accountable role or person and any additional specialist or product-owner approval required before completion.
