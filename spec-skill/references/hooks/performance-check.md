# Performance Check Hook

## Purpose

Detect obvious performance risks and provide practical optimization actions before release.

## When to Use

- Before merging performance-sensitive features
- After introducing heavy data processing or query changes
- Before production deployment

## Execution Rules

1. Focus on measurable bottlenecks, not speculative micro-optimizations.
2. Prioritize hot paths and user-visible latency first.
3. Provide baseline and post-change metrics when possible.

## Steps

### 1) Identify critical paths

- Frequently executed code
- Slow endpoints/queries
- Expensive loops, serialization, or rendering

### 2) Check algorithmic and data-structure choices

- Look for avoidable O(n^2) patterns
- Replace repeated scans with indexed/set-based lookups where appropriate
- Remove repeated expensive recomputation

### 3) Check storage/query behavior

- Query count inflation (N+1 patterns)
- Missing index usage on hot filters/joins
- Unbounded reads without pagination/limits

### 4) Check memory/resource behavior

- Unbounded caches/collections
- Unreleased connections/handles
- Large object retention in long-lived processes

### 5) Verify with measurements

- Run benchmark/load/profiling commands available in repo
- Compare against baseline or target SLOs

### 6) Report and prioritize

Classify findings:
- Critical: likely production impact
- Important: meaningful regression risk
- Minor: optimization opportunity

Include:
- Observed symptom
- Evidence (`path:line` and/or metric)
- Recommended action and expected gain

## Validation

This hook passes only if:
- No critical unmitigated bottlenecks remain
- Key paths meet accepted performance expectations
- Any accepted trade-offs are explicitly documented
