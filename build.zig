const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const lib = b.addSharedLibrary(.{
        .name = "httpz",
        .target = target,
        .optimize = optimize,
    });

    lib.linkSystemLibrary("lua");
    lib.linkSystemLibrary("curl");
    lib.addCSourceFile(.{ .file = .{
        .src_path = .{ .owner = b, .sub_path = "httpz.c" },
    } });

    b.installArtifact(lib);
}
