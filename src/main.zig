const std = @import("std");
const vec = @import("./vec/vec.zig");
const Color = @import("./color/Color.zig");
const Ray = @import("./ray/Ray.zig");

pub fn main() !void {
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    const aspect_ratio = 16.0 / 9.0;
    const image_width = 400;
    const image_height = @as(u32, @intFromFloat(@as(f64, @floatFromInt(image_width)) / aspect_ratio));

    const viewport_height = 2.0;
    const viewport_width = aspect_ratio * viewport_height;
    const focal_length = 1.0;

    const origin = Ray.point3{ 0, 0, 0 };
    const horizontal = vec.Vec3{ viewport_width, 0, 0 };
    const vertical = vec.Vec3{ 0, viewport_height, 0 };
    const lower_left_corner = origin - vec.scalar(horizontal, 0.5) - vec.scalar(vertical, 0.5) - vec.Vec3{ 0, 0, focal_length };

    try stdout.print("P3\n{} {}\n255\n", .{ image_width, image_height });

    var j: usize = image_height - 1;
    while (true) : (j -= 1) {
        for (0..image_width) |i| {
            const u = @as(f64, @as(f64, @floatFromInt(i)) / @as(f64, @floatFromInt(image_width - 1)));
            const v = @as(f64, @as(f64, @floatFromInt(j)) / @as(f64, @floatFromInt(image_height - 1)));
            const r = Ray{
                .orig = origin,
                .dir = lower_left_corner + vec.scalar(horizontal, u) + vec.scalar(vertical, v) - origin,
            };

            const pixel_color = Ray.ray_color(r);
            try Color.writeColor(stdout.any(), pixel_color);
        }
        if (j == 0) break;
    }

    try bw.flush();
}
