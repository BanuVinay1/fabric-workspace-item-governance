## what this does
Audits Microsoft Fabric workspaces and items to enforce capacity and cost governance

## why do we need this
In large tenants, orphaned workspaces and high-cost Fabric items sush as Warehouses, excessive Lakehouses, RIT items such as EventStream silently consume capacity and drive cost overruns.

## what is checked
- Orphaned workspaces
- Capacity alignment
- High-risk item types

## how it runs
-- GitHub actions (shceduled and manual)
-- SP authentication
