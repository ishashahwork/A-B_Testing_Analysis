# A/B_Testing_Analysis

A fast-food chain plans to add a new item to its menu. However, they are still undecided between three possible marketing campaigns for promoting the new product. In order to determine which promotion has the greatest effect on sales, the new item is introduced at locations in several randomly selected markets. A different promotion is used at each location, and the weekly sales of the new item are recorded for the first four weeks.

Goal: Evaluate A/B testing results and decide which marketing strategy works the best.

Key Findings:
1. SQL Analysis Results
The average sales per promotion showed that Promotion 1 had the highest sales (58.1K), followed by Promotion 3 (55.4K), and Promotion 2 had the lowest sales (47.3K).
The weekly trend analysis showed that these differences in sales remained consistent across all four weeks, meaning the effect of promotions was stable over time.

2. R Statistical Results
ANOVA (Testing if promotions differ significantly)
The ANOVA test showed a highly significant difference (p-value = 6.77e-10), confirming that at least one promotion performed significantly better than the others.

Tukey's HSD Test (Comparing specific promotions)
Promotion 1 vs. Promotion 2:
Promotion 1 performed significantly better than Promotion 2 (+10.77K in sales, p < 0.0001).
This means Promotion 1 was far more effective than Promotion 2.
Promotion 3 vs. Promotion 2:
Promotion 3 also performed significantly better than Promotion 2 (+8.04K in sales, p = 0.0000055).
This shows Promotion 2 was the least effective strategy.
Promotion 1 vs. Promotion 3:
There was no significant difference (p = 0.2444), meaning both Promotion 1 and Promotion 3 performed similarly.

Assumption Tests (Checking if data meets statistical assumptions)
Shapiro-Wilk Normality Test: p-value < 0.05 → Data is not normally distributed. However, ANOVA is robust with large samples.
Levene's Test for Variance Homogeneity: p-value = 0.28 → Variances are equal, so ANOVA results are valid.

Recommendations:
1. Best Promotion Strategy
Use Promotion 1 (Highest sales, significantly better than Promotion 2).
Promotion 3 is a good alternative (Almost as good as Promotion 1).
Drop Promotion 2 (Lowest performance, significantly worse than the other two).
2. Marketing & Psychology-Based Insights
Framing Effect: If Promotion 2 involved heavy discounts, it may have been perceived as lower quality ("cheap" rather than "good value").
Anchoring Bias: Promotion 1 may have created a higher perceived value by setting a strong initial price point or emphasizing exclusivity.
Scarcity & Urgency: If Promotion 1 or 3 involved a limited-time offer, this may have increased demand.
3. Next Steps
Implement Promotion 1 across all markets since it consistently outperformed Promotion 2.
Consider modifying Promotion 2 by adjusting its messaging (e.g., framing a discount as "exclusive savings" rather than "low price").
A/B test Promotion 1 vs. Promotion 3 further to determine if any external factors influenced the results.
Analyze demographic/market-size effects to ensure the promotion works well across different locations.
