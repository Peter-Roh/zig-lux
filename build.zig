const std = @import("std");
const builtin = @import("builtin");

const min_zig_version = "0.13.0";

const Build = blk: {
    const current_zig = builtin.zig_version;
    const min_zig = std.SemanticVersion.parse(min_zig_version) catch unreachable;
    if (current_zig.order(min_zig) == .lt) {
        @compileError(std.fmt.comptimePrint("Your Zig version {} does not meet the minimum build requirement of {}", .{ current_zig, min_zig }));
    }
    break :blk std.Build;
};

pub fn build(b: *Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe = b.addExecutable(.{
        .name = "zig-lux",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());

    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const generate_image = b.addSystemCommand(&[_][]const u8{
        "sh", "-c", "./zig-out/bin/zig-lux > image.ppm",
    });

    const run_step = b.step("run", "Compile and generate the image");

    generate_image.step.dependOn(&run_cmd.step);
    run_step.dependOn(&generate_image.step);
}
