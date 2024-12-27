# CppUTest Zig

Using zig build system to build [CppUTest](https://github.com/cpputest/cpputest) unit test library.

## Adding It to your project

First update your *build.zig.zon* with:

```bash
zig fetch --save git+https://github.com/lcp5y3/cpputest-zig.git#v4.0.0
```

After that you can link `CppUTest` with your project by adding the following
lines to your `build.zig`

```zig
const cpputest_dep = b.dependency("cpputest_zig", .{
  .target = target,
  .optimize = optimize,
});

exe.linkLibrary(cpputest_dep.artifact("CppUTest"));
exe.linkLibrary(cpputest_dep.artifact("CppUTestExt"));
```

## Building the lib

If you only want to build CppUTest to get .a and header, run:

```bash
zig build
```
