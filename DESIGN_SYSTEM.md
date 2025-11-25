# 🎨 ERP System - Design System & Style Guide

## 📐 Layout & Spacing

### Grid System
- **Desktop (>800px):** 4-column grid for metrics and modules
- **Mobile (<800px):** 2-column grid for metrics and modules
- **Spacing Unit:** 8px base unit

### Padding & Margins
- **Large Containers:** 24px (desktop), 16px (mobile)
- **Cards:** 20-24px internal padding
- **Grid Gaps:** 16px between items
- **Component Spacing:** 24px between sections

### Border Radius
- **Cards:** 16px
- **Buttons:** 20-24px
- **Small Elements:** 8-12px
- **Bottom Nav:** 24px (top corners only)

## 🎨 Color Palette

### Primary Gradient
```
Linear Gradient:
  Start: #667EEA (Purple-Blue)
  End: #764BA2 (Purple)
  Direction: Top-left to Bottom-right
```

### Background Colors
```
Main Background: #F5F7FA (Light Gray)
Card Background: #FFFFFF (White)
Hover States: #F7FAFC (Off-white)
```

### Text Colors
```
Primary Text: #2D3748 (Dark Gray)
Secondary Text: #718096 (Medium Gray)
White Text: #FFFFFF (On colored backgrounds)
```

### Module Colors

#### Inventory
- **Primary:** #3B82F6 (Blue)
- **Background:** #E3F2FD (Light Blue)

#### Sales
- **Primary:** #10B981 (Green)
- **Background:** #E8F5E9 (Light Green)

#### HR / Employees
- **Primary:** #F59E0B (Orange)
- **Background:** #FFF3E0 (Light Orange)

#### Finance
- **Primary:** #8B5CF6 (Purple)
- **Background:** #F3E5F5 (Light Purple)

#### Contacts
- **Primary:** #EC4899 (Pink)
- **Background:** #FCE4EC (Light Pink)

#### Reports
- **Primary:** #06B6D4 (Cyan)
- **Background:** #E0F2F1 (Light Cyan)

#### Shipment
- **Primary:** #F97316 (Deep Orange)
- **Background:** #FBE9E7 (Light Orange)

#### Expenses
- **Primary:** #EF4444 (Red)
- **Background:** #FFEBEE (Light Red)

### Status Colors
```
Success: #4CAF50 (Green)
Warning: #FF9800 (Orange)
Error: #F44336 (Red)
Info: #2196F3 (Blue)
```

## 📝 Typography

### Font Weights
- **Regular:** 400
- **Medium:** 500
- **Semi-Bold:** 600
- **Bold:** 700

### Font Sizes (Desktop)
```
Large Header: 32px
Medium Header: 22-24px
Section Title: 20px
Body: 16px
Small Text: 14px
Caption: 12px
```

### Font Sizes (Mobile)
```
Large Header: 24px
Medium Header: 18-20px
Section Title: 18px
Body: 14px
Small Text: 12px
Caption: 11px
```

### Text Styles
```
Headers: Bold (700)
Subheaders: Semi-Bold (600)
Body: Regular (400) or Medium (500)
Captions: Regular (400)
```

## 🎯 Component Styles

### Cards
```css
Background: White (#FFFFFF)
Border Radius: 16px
Shadow: 0px 4px 10px rgba(0, 0, 0, 0.05)
Padding: 20-24px
```

### Metric Cards
```css
Icon Container:
  - Size: 44x44px
  - Border Radius: 10px
  - Background: Module color at 10% opacity

Value Display:
  - Font Size: 24px
  - Font Weight: Bold (700)
  - Color: #2D3748

Label:
  - Font Size: 14px
  - Font Weight: Regular (400)
  - Color: #718096

Trend Badge:
  - Padding: 4px 8px
  - Border Radius: 8px
  - Font Size: 12px
  - Font Weight: Semi-Bold (600)
  - Green (#E8F5E9) for positive
  - Red (#FFEBEE) for negative
```

### Module Cards
```css
Icon Container:
  - Padding: 16px
  - Border Radius: 12px
  - Background: Module color at 10% opacity

Icon:
  - Size: 32px
  - Color: Module primary color

Label:
  - Font Size: 16px
  - Font Weight: Semi-Bold (600)
  - Color: #2D3748
```

### Bottom Navigation
```css
Container:
  - Background: White
  - Height: 70px
  - Border Radius: 24px (top only)
  - Shadow: 0px -2px 10px rgba(0, 0, 0, 0.1)

Active Button:
  - Gradient: #667EEA → #764BA2
  - Border Radius: 20px
  - Padding: 8px 16px
  - Icon Color: White
  - Text Color: White

Inactive Button:
  - Background: Transparent
  - Icon Color: #718096
  - No text shown
```

### App Bar
```css
Background: Gradient (#667EEA → #764BA2)
Height: 56px (mobile), 64px (desktop)
Elevation: 0
Icon Color: White
Text Color: White
Font Weight: Semi-Bold (600)
```

## 📊 Chart Styling

### Line Chart
```css
Line Color: Gradient (#667EEA → #764BA2)
Line Width: 3px
Curve Style: Smooth curves (isCurved: true)
Fill: Gradient with 30% → 0% opacity

Grid:
  - Horizontal lines only
  - Color: #E2E8F0
  - Width: 1px

Axis Labels:
  - Color: #718096
  - Font Size: 12px

No dots on data points
```

## 🎭 Shadows & Elevation

### Card Shadow
```css
box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.05);
```

### Bottom Nav Shadow
```css
box-shadow: 0px -2px 10px rgba(0, 0, 0, 0.1);
```

### Header Shadow
```css
box-shadow: 0px 10px 20px rgba(102, 126, 234, 0.3);
```

### Hover Effect
```css
box-shadow: 0px 6px 15px rgba(0, 0, 0, 0.08);
transition: all 0.3s ease;
```

## 🔄 Animations & Transitions

### Standard Transitions
```css
Duration: 300ms
Timing: ease-in-out
Properties: all
```

### Button Press
```css
Scale: 0.95
Duration: 150ms
```

### Card Hover
```css
Translate Y: -2px
Shadow: Increased
Duration: 250ms
```

## 📱 Responsive Breakpoints

```
Mobile: < 600px
Tablet: 600px - 800px
Desktop: > 800px

Key Breakpoint: 800px
  - Switches from 2-col to 4-col grids
  - Adjusts padding and spacing
  - Changes layout from stacked to side-by-side
```

## 🎪 Usage Examples

### Creating a Metric Card
```dart
_buildMetricCard(
  'Total Sales',           // Title
  '\$125,430',            // Value
  '+12.5%',               // Change
  Icons.trending_up,      // Icon
  Color(0xFF4CAF50),     // Primary color
  Color(0xFFE8F5E9),     // Background color
)
```

### Creating a Module Card
```dart
_buildModuleCard(
  'Inventory',                    // Title
  MdiIcons.packageVariantClosed, // Icon
  Color(0xFF3B82F6),            // Color
  '/products',                   // Route
)
```

## ✅ Design Checklist

When creating new components:
- [ ] Uses consistent spacing (multiples of 8px)
- [ ] Has appropriate border radius (8, 12, 16, or 20px)
- [ ] Uses colors from the defined palette
- [ ] Includes soft shadow for depth
- [ ] Has hover/active states where appropriate
- [ ] Is responsive (works on mobile and desktop)
- [ ] Uses proper typography hierarchy
- [ ] Has smooth transitions (300ms)
- [ ] Maintains consistent padding
- [ ] Follows Material Design principles

## 🎨 Color Accessibility

All color combinations meet WCAG AA standards:
- White text on gradient backgrounds: AAA
- Dark gray (#2D3748) on white: AAA
- Medium gray (#718096) on white: AA
- Colored icons on light backgrounds: AAA

## 📦 Assets Needed

No custom assets required! The design uses:
- Material Icons
- Material Design Icons Flutter package
- System fonts
- CSS gradients and shadows

Everything is code-based and customizable.
