# Decision Log

## D001 - Use hub-and-spoke as target architecture
Reason:
Centralize shared services and keep workloads isolated by spoke.

## D002 - Use phased delivery
Reason:
Full enterprise deployment is too large and too costly for a 12-day trial.

## D003 - Phase 1 will deploy only a low-cost PoC
Reason:
Need a real Azure implementation without wasting trial credit.

## D004 - AKS remains design-only for now
Reason:
Private AKS adds cost and complexity beyond the current trial scope.

## D005 - Hybrid connectivity remains conceptual
Reason:
VPN Gateway / ExpressRoute is not appropriate for the initial low-cost PoC.