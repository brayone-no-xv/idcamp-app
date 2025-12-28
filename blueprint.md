# Blueprint

## Overview

This is a Flutter application that serves as a dashboard with interactive features and a modern design. It includes a theme toggle for light and dark modes, statistics cards, a performance chart, and social media buttons.

## Style and Design

*   **Theming:** The application uses a centralized theme management system with `provider`. It features distinct light and dark themes with a consistent color scheme and typography.
*   **Fonts:** `google_fonts` is used to apply custom fonts (`Oswald` for headings, `Roboto` for titles, and `Open Sans` for body text).
*   **Components:**
    *   **App Bar:** A custom app bar with a title and a theme toggle button.
    *   **Stat Cards:** Cards with elevation and rounded corners to display key statistics. Icons are used to visually represent the data.
    *   **Chart:** A line chart from the `fl_chart` package to visualize data trends. The chart has a gradient fill and curved lines for a modern look.
    *   **Social Buttons:** Circular buttons with a "glow" effect, achieved with a `BoxShadow`. Each button has a distinct color associated with the social media platform it represents.

## Features

*   **Theme Toggle:** Users can switch between light and dark modes.
*   **Dashboard:** The main screen displays a dashboard with:
    *   **Statistics:** Cards showing follower count, likes, and posts.
    *   **Performance Chart:** A chart visualizing performance data over a period.
    *   **Social Media Links:** Buttons to link to various social media platforms.
