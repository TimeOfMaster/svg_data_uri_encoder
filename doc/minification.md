# SVG Minification

The SVG Data URI Encoder provides powerful minification capabilities through the `-m` or `--minify` flag.

## Optimization Steps

### 1. Whitespace Optimization

- Removes unnecessary spaces, newlines, and tabs
- Preserves whitespace in text elements
- Combines multiple spaces into single spaces where needed

### 2. Path Optimization

- Shortens path commands (e.g., 'L' → 'l' where beneficial)
- Reduces number precision (e.g., 3.14159 → 3.142)
- Combines compatible path segments
- Removes redundant commands

### 3. Attribute Optimization

- Removes default attribute values
- Shortens color values (e.g., #000000 → #000)
- Removes unnecessary units (e.g., 0px → 0)
- Combines style attributes where possible

### 4. Structure Optimization

- Removes empty groups and containers
- Merges nested groups when possible
- Removes unused namespace declarations
- Eliminates redundant transformations

## Example

Before minification:

```xml
<svg width="100px" height="100px" viewBox="0 0 100 100">
    <g>
        <circle cx="50.000" cy="50.000" r="40.000" fill="#000000"/>
    </g>
</svg>
```

After minification:

```xml
<svg width="100" height="100" viewBox="0 0 100 100"><circle cx="50" cy="50" r="40" fill="#000"/></svg>
```

## Usage

```bash
dart run bin/svg_data_uri_encoder.dart icon.svg -m
```