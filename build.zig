const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addSharedLibrary(.{
        .name = "httpz",
        .target = target,
        .optimize = optimize,
    });

    const lua_dep = b.dependency("lua", .{
        .target = target,
        .release = optimize != .Debug,
    });
    const lua_lib = lua_dep.artifact("lua");

    lib.linkLibrary(lua_lib);
    lib.linkSystemLibrary("curl");
    lib.addCSourceFile(.{
        .file = .{
            .src_path = .{ .owner = b, .sub_path = "httpz.c" },
        },
    });
    lib.linkLibC();
    b.installArtifact(lib);
}
