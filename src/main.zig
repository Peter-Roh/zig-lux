const std = @import("std");

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
            const r = @as(f64, @floatFromInt(i)) / @as(f64, @floatFromInt(IMAGE_WIDTH - 1));
            const g = @as(f64, @floatFromInt(j)) / @as(f64, @floatFromInt(IMAGE_HEIGHT - 1));
            const b = 0.25;

            const ir = @as(u8, @intFromFloat(r * 255.999));
            const ig = @as(u8, @intFromFloat(g * 255.999));
            const ib = @as(u8, @intFromFloat(b * 255.999));

            try stdout.print("{} {} {}\n", .{ ir, ig, ib });
        }
        if (j == 0) break;
    }

    try bw.flush();
}
