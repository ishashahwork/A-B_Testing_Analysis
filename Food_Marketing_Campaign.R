# Load necessary libraries
library(dplyr)
library(ggplot2)
library(car)
library(multcompView)

insdf <- read_xlsx("Food_Marketing_Campaign.xlsx") 
# Convert categorical variables to factors
df$Promotion <- as.factor(df$Promotion)
df$MarketID <- as.factor(df$MarketID)
df$LocationID <- as.factor(df$LocationID)
df$week <- as.factor(df$Week)

# Summary statistics for each promotion
summary_stats <- df %>%
  group_by(Promotion) %>%
  summarise(
    AvgSales = mean(SalesInThousands, na.rm = TRUE),
    StdDev = sd(SalesInThousands, na.rm = TRUE),
    SampleSize = n()
  )
print(summary_stats)

# Define pastel colors for the promotions
pastel_colors <- c("#FFB3BA", "#B3E2CD", "#B3CDE3")  # Soft pastel shades

# Customizing the box plot with pastel colors & transparent outliers
ggplot(df, aes(x = Promotion, y = SalesInThousands, fill = Promotion)) +
  geom_boxplot(outlier.color = "#FF9999", outlier.shape = 16, outlier.size = 2, outlier.alpha = 0.5, alpha = 0.7) +  
  scale_fill_manual(values = pastel_colors) +  # Apply pastel colors
  theme_minimal(base_size = 14) +  # Clean theme with readable text
  labs(title = "Sales Distribution by Promotion",
       subtitle = "Comparing the effectiveness of different marketing strategies",
       x = "Promotion Type",
       y = "Sales (in Thousands)",
       fill = "Promotion") +
  theme(legend.position = "top", 
        plot.title = element_text(face = "bold", size = 16),
        axis.text.x = element_text(face = "bold"),
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"))


# Checking for normality using Shapiro-Wilk test
shapiro_test <- shapiro.test(df$SalesInThousands)
print(shapiro_test)  # If p-value > 0.05, data is approximately normal

# Checking homogeneity of variances using Levene's Test
levene_test <- leveneTest(SalesInThousands ~ Promotion, data = df)
print(levene_test)  # If p-value > 0.05, equal variances assumed

# ANOVA test to check for significant differences
anova_result <- aov(SalesInThousands ~ Promotion, data = df)
summary(anova_result)

# Post-hoc test (Tukey's HSD) if ANOVA is significant
tukey_result <- TukeyHSD(anova_result)
print(tukey_result)

# Load necessary libraries
library(ggplot2)

# Define pastel color for the point range
pastel_color <- "#A3C1AD"  # Soft pastel green
line_color <- "#F4A582"    # Light pastel orange for the reference line

# Convert Tukey results into a data frame
tukey_df <- as.data.frame(TukeyHSD(anova_result)$Promotion)

# Add comparison names
tukey_df$Comparison <- rownames(tukey_df)

# Create a pastel-themed Tukey HSD plot
ggplot(tukey_df, aes(x = reorder(Comparison, diff), y = diff, ymin = lwr, ymax = upr)) +
  geom_pointrange(color = pastel_color, size = 1.2, alpha = 0.8) +  # Soft pastel color with transparency
  geom_hline(yintercept = 0, linetype = "dashed", color = line_color, size = 1) +  # Pastel reference line
  coord_flip() +  # Flip for better readability
  theme_minimal(base_size = 14) +
  labs(title = "Tukey HSD Test for Promotion Comparisons",
       subtitle = "Mean Differences with 95% Confidence Intervals",
       x = "Promotion Comparison",
       y = "Mean Difference in Sales (Thousands)") +
  theme(plot.title = element_text(face = "bold", size = 16),
        axis.title.x = element_text(face = "bold"),
        axis.title.y = element_text(face = "bold"))

