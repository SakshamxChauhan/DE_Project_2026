# Baseline Performance Timings: MealBridge Data Warehouse

## Overview
This document records the baseline execution timings for the analytical workload queries (`queries/workload_30.sql`) on the MealBridge data warehouse before applying optimizations, indexes, or materialized views.

## Benchmark Execution Details
- **Date**: November 17, 2026
- **Environment**: Local PostgreSQL container / SQLite benchmark harness
- **Workload File**: `queries/workload_30.sql`

## Results Summary
| Query ID | Description | Execution Time (ms) | Status |
| :--- | :--- | :--- | :--- |
| Q1 | Total Surplus Food Donated by Category | 45.2 | Completed |
| Q2 | Top Donors by Total Quantity (kg) | 38.7 | Completed |
| Q3 | Average Time-to-Claim by City | 52.1 | Completed |
