const std = @import("std");
const Vec3 = @import("../vec3/Vec3.zig");

const Color = Vec3;

pub fn writeColor(writer: std.io.AnyWriter, pixelColor: Color) !void {
    const r = pixelColor.x();
    const g = pixelColor.y();
    const b = pixelColor.z();

    const rbyte = @as(u8, @intFromFloat(r * 255.999));
    const gbyte = @as(u8, @intFromFloat(g * 255.999));
    const bbyte = @as(u8, @intFromFloat(b * 255.999));

    try writer.print("{d} {d} {d}\n", .{ rbyte, gbyte, bbyte });
}
