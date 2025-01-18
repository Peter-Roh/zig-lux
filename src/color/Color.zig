const std = @import("std");
const vec = @import("../vec/vec.zig");

const Color = vec.Vec3;

pub fn writeColor(writer: std.io.AnyWriter, pixelColor: Color) !void {
    const r = pixelColor[0];
    const g = pixelColor[1];
    const b = pixelColor[2];

    const rbyte = @as(u8, @intFromFloat(r * 255.999));
    const gbyte = @as(u8, @intFromFloat(g * 255.999));
    const bbyte = @as(u8, @intFromFloat(b * 255.999));

    try writer.print("{d} {d} {d}\n", .{ rbyte, gbyte, bbyte });
}
