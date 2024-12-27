const std = @import("std");

pub fn build(b: *std.Build) void {
    const cpputest_dep = b.dependency("cpputest", .{});
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const cpputest = b.addStaticLibrary(.{
        .name = "CppUTest",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    cpputest.addCSourceFiles(.{
        .root = cpputest_dep.path("src/CppUTest"),
        .files = &CPPUTEST_SRC,
        .flags = &FLAGS,
    });
    cpputest.installHeadersDirectory(cpputest_dep.path("include/CppUTest"), "CppUTest", .{});
    cpputest.addIncludePath(cpputest_dep.path("include"));
    cpputest.linkLibCpp();

    const cpputest_ext = b.addStaticLibrary(.{
        .name = "CppUTestExt",
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });

    cpputest_ext.addCSourceFiles(.{
        .root = cpputest_dep.path("src/CppUTestExt"),
        .files = &CPPUTEST_EXT_SRC,
        .flags = &FLAGS,
    });
    cpputest_ext.installHeadersDirectory(cpputest_dep.path("include/CppUTestExt"), "CppUTestExt", .{});
    cpputest_ext.addIncludePath(cpputest_dep.path("include"));
    cpputest_ext.linkLibCpp();

    b.installArtifact(cpputest);
    b.installArtifact(cpputest_ext);
}

const CPPUTEST_SRC = [_][]const u8{
    "CommandLineArguments.cpp",
    "CommandLineTestRunner.cpp",
    "JUnitTestOutput.cpp",
    "MemoryLeakDetector.cpp",
    "MemoryLeakWarningPlugin.cpp",
    "SimpleMutex.cpp",
    "SimpleString.cpp",
    "SimpleStringInternalCache.cpp",
    "TeamCityTestOutput.cpp",
    "TestFailure.cpp",
    "TestFilter.cpp",
    "TestHarness_c.cpp",
    "TestMemoryAllocator.cpp",
    "TestOutput.cpp",
    "TestPlugin.cpp",
    "TestRegistry.cpp",
    "TestResult.cpp",
    "TestTestingFixture.cpp",
    "Utest.cpp",
};

const CPPUTEST_EXT_SRC = [_][]const u8{
    "CodeMemoryReportFormatter.cpp",
    "GTest.cpp",
    "IEEE754ExceptionsPlugin.cpp",
    "MemoryReportAllocator.cpp",
    "MemoryReporterPlugin.cpp",
    "MemoryReportFormatter.cpp",
    "MockActualCall.cpp",
    "MockExpectedCall.cpp",
    "MockExpectedCallsList.cpp",
    "MockFailure.cpp",
    "MockNamedValue.cpp",
    "MockSupport_c.cpp",
    "MockSupport.cpp",
    "MockSupportPlugin.cpp",
    "OrderedTest.cpp",
};

const FLAGS = [_][]const u8{
    "-std=c++20",
};
