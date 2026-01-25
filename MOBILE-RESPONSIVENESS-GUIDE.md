# Mobile Responsiveness & Breakpoints Reference

## CSS Breakpoints Applied

### Breakpoint 1: Tablet & Smaller (max-width: 1024px)
Applied to:
- `.free-stats-content` - Switches from 2 columns to 1
- `.motorbike-content` - Switches from 2 columns to 1
- `.about-grid` - Switches from 2 columns to 1
- `.service-with-images` - Switches from 2-column (300px + 1fr) to 1 column

### Breakpoint 2: Mobile (max-width: 768px)
Comprehensive mobile styling applied to:

**Typography**
- h1: Full width, reduced size for readability
- h2: Reduced to 1.8rem 
- h3: Reduced to 1.3rem

**Sections**
- All section padding reduced from 80px to 3rem (48px)
- Improved vertical spacing on mobile

**Grids & Layouts**
- `.benefits-grid` → 1 column
- `.featured-grid` → 1 column
- `.examples-grid` → 1 column
- `.about-stats` → 1 column

**Buttons**
- All CTA buttons become full-width (100%)
- Stacked vertically with consistent spacing
- `.btn-large`: 1rem padding with !important
- `.btn-small`: 0.7rem padding

**Service Cards**
- `.modern-service-card`: 1.5rem padding
- `.service-card-footer`: flex-direction: column
- `.service-card-icon`: Reduced to 2.5rem

**Pricing**
- `.price-tag`: Reduced to 1.3rem
- Pricing cards stack on mobile

**Forms**
- `.form-row`: 1 column layout
- Input fields full-width

**Addon Grid**
- `.addons-grid`: 3-column layout (instead of 6)
- Compact spacing at 1rem gap

**Navigation**
- Already implemented hamburger menu for mobile
- Menu animation and toggle working properly

### Breakpoint 3: Very Small Phones (max-width: 480px)
Ultra-compact styling for small screens:

**Typography**
- h1: 1.5rem
- h2: 1.4rem
- h3: 1.1rem

**Buttons**
- Ultra-compact: 0.75rem padding
- Font size: 0.9rem
- Still maintain proper touch targets

**Stage Cards**
- 1.2rem padding (very compact)
- .stage-number: 1.8rem
- .stage-price span: 1.5rem

**Addon Grid**
- 3 columns with 0.8rem gap
- Ultra-compact display

---

## Grid Template Changes

### Auto-fit Responsive Grids
Used `repeat(auto-fit, minmax(X, 1fr))` pattern for flexible layouts:

```css
/* Stages Grid */
grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
/* Works: 1 col (280px+0px), 2 cols (~560px), 3 cols (~840px), 4 cols (1120px+) */

/* Addons Grid */
grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
/* Works: 1 col (150px), 2 cols (300px), 3 cols (450px), 4 cols (600px), 5 cols (750px), 6 cols (900px+) */

/* Benefits Grid */
grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
/* Works: 1 col (320px), 2 cols (640px), 3 cols (960px), 4 cols (1280px+) */
```

---

## Device Width Reference

| Device Type | Width | Applied Breakpoint |
|---|---|---|
| iPhone 5/SE | 320px | 480px |
| iPhone 6/7/8 | 375px | 480px → 768px |
| iPhone 12/13 | 390px | 480px → 768px |
| Android Medium | 412px | 480px → 768px |
| Android Large | 480px | 768px |
| iPad Mini | 768px | 768px |
| iPad Regular | 810px | 1024px |
| iPad Pro | 1024px | 1024px+ |
| Desktop | 1200px+ | 1024px+ (no change) |

---

## Specific Changes by Component

### Hero Sections
```
Desktop:  Font-size 3.5rem
Tablet:   Font-size 2.5rem (< 1024px)
Mobile:   Font-size 2rem (< 768px)
Very Small: Font-size 1.5rem (< 480px)
```

### Service Cards
```
Desktop:  2rem padding, full features visible
Mobile:   1.5rem padding (< 768px)
Very Small: 1.2rem padding (< 480px)
Icon size: 3.5rem → 2.5rem (< 768px)
```

### Addon Items
```
Desktop:  6 columns, 1.5rem padding
Tablet:   Auto-fit (300px minmax)
Mobile:   3 columns, 1rem padding (< 768px)
Very Small: 3 columns, 0.8rem padding (< 480px)
```

### Stage Cards
```
Desktop:  3 columns, 2rem padding
Mobile:   1 column, 1.5rem padding (< 768px)
Very Small: 1 column, 1.2rem padding (< 480px)
Number:   3rem → 2rem (< 768px) → 1.8rem (< 480px)
```

---

## Media Query Organization in CSS

### Primary Mobile Query
**Location**: Near end of CSS file
**Rule**: `@media (max-width: 768px) { ... }`
**Content**: 100+ styling rules for tablet and mobile optimization

### Secondary Mobile Query  
**Location**: After primary query
**Rule**: `@media (max-width: 480px) { ... }`
**Content**: 50+ styling rules for very small devices

### Desktop-Up Queries
**Locations**: Embedded near component definitions
**Rules**: `@media (min-width: 1024px) { ... }`
**Examples**:
- `.free-stats-content` switches 1→2 columns
- `.motorbike-content` switches 1→2 columns
- `.about-grid` switches 1→2 columns

---

## Testing Checklist

- [ ] Responsive on iPhone 5 (320px)
- [ ] Responsive on iPhone 12 (390px)
- [ ] Responsive on Android phones (360-480px)
- [ ] Responsive on iPad (768px)
- [ ] Responsive on iPad Pro (1024px)
- [ ] Desktop view (1200px+)
- [ ] All buttons are touch-friendly (44px+ minimum)
- [ ] No horizontal scrolling on mobile
- [ ] Images scale properly
- [ ] Text is readable (16px+ on mobile)
- [ ] Forms are easy to use on mobile
- [ ] Navigation works on all sizes
- [ ] Grids stack appropriately

---

## Future Optimization Ideas

1. **Picture Element**: Use `<picture>` for responsive images
2. **Fluid Typography**: Implement CSS clamp() for scalable font sizes
3. **Mobile Navigation**: Consider sticky header for easier navigation
4. **Touch Targets**: Ensure all interactive elements are 44x44px minimum
5. **Performance**: Lazy load images with `loading="lazy"` attribute
6. **Viewport Settings**: Already configured correctly in meta tags

---

## Notes

- All media queries use `max-width` (mobile-first approach works bottom-up)
- Inline `!important` flags ensure mobile styles override desktop defaults
- Grid auto-fit system provides "fluid" responsive behavior
- No fixed widths used on main containers (all percentage/flex/grid based)
- CSS variables maintained for easy theming
