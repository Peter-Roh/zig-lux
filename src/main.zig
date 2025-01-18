const std = @import("std");
const Color = @import("./color/Color.zig");

pub fn main() !void {
    const IMAGE_WIDTH = 256;
    const IMAGE_HEIGHT = 256;

    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    try stdout.print("P3\n{} {}\n255\n", .{ IMAGE_WIDTH, IMAGE_HEIGHT });

    var j: usize = IMAGE_HEIGHT - 1;
    while (true) : (j -= 1) {
        for (0..IMAGE_WIDTH) |i| {
            const pixel_color = @Vector(3, f64){
                @as(f64, @floatFromInt(i)) / @as(f64, @floatFromInt(IMAGE_WIDTH - 1)),
                @as(f64, @floatFromInt(j)) / @as(f64, @floatFromInt(IMAGE_HEIGHT - 1)),
                0.25,
            };
            try Color.writeColor(stdout.any(), pixel_color);
        }
        if (j == 0) break;
    }

    try bw.flush();
}
