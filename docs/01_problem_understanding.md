# Problem Understanding: MealBridge Data Engineering

## 1. Background & Domain
MealBridge bridges the gap between surplus food generators (restaurants, caterers, hotels, grocery stores) and food recovery organizations (shelters, orphanages, community kitchens). The Advanced Programming (AP) backend manages operational transactional workflows (user signups, live food postings, claims, and status updates). 

## 2. Data Engineering Objective
While the AP database handles real-time OLTP (Online Transaction Processing) operations, this DE repository implements an OLAP (Online Analytical Processing) architecture. The goal is to:
- Extract raw operational data periodically from the AP backend.
- Clean, normalize, and transform transaction logs.
- Populate an analytical Data Warehouse using dimensional modeling (Star Schema) to generate performance metrics, waste-reduction impact reports, and redistribution efficiencies.
