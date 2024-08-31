const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addSharedLibrary(.{
        .name = "httpz",
        .target = target,
        .optimize = optimize,
    });

    const curl_dep = b.dependency("curl", .{
        .target = target,
        .optimize = optimize,
    });
    const lua_dep = b.dependency("lua", .{
        .target = target,
        .optimize = optimize,
    });
    lib.addIncludePath(curl_dep.path("include"));
    lib.addIncludePath(lua_dep.path(""));

    lib.addCSourceFile(.{
        .file = .{
            .src_path = .{ .owner = b, .sub_path = "httpz.c" },
        },
    });

    lib.linkLibC();
    b.installArtifact(lib);
}
