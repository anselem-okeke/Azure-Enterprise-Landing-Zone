# Day 14 Notes

## Completed
- Integrated AKS into the documented landing zone architecture
- Updated the dev spoke subnet intent to include a dedicated AKS node subnet
- Updated the main README with AKS Phase 2 status
- Added a Mermaid diagram showing AKS in the dev spoke
- Clarified current vs future AKS access model
- Documented AKS subnet security posture

## Key outcome
The project now shows how AKS fits into the landing zone as a workload platform component, rather than appearing as an isolated add-on.

## Current AKS position
- one AKS cluster in the dev spoke
- dedicated AKS node subnet
- public API retained for current PoC simplicity

## Future direction
- private or VNet-integrated AKS API model
- production AKS spoke
- CI/CD integration
- further private service consumption patterns
