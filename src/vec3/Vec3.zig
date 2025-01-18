const std = @import("std");
const math = std.math;
const testing = std.testing;

const Vec3 = @Vector(3, f64);

pub fn lengthSquared(v: Vec3) f64 {
    return v[0] * v[0] + v[1] * v[1] + v[2] * v[2];
}

pub fn length(v: Vec3) f64 {
    return math.sqrt(lengthSquared(v));
}

pub fn unitVector(v: Vec3) Vec3 {
    const len = length(v);
    return @Vector(3, f64){ v[0] / len, v[1] / len, v[2] / len };
}

pub fn cross(u: Vec3, v: Vec3) Vec3 {
    return @Vector(3, f64){
        u[1] * v[2] - u[2] * v[1],
        u[2] * v[0] - u[0] * v[2],
        u[0] * v[1] - u[1] * v[0],
    };
}

pub fn print(v: Vec3) void {
    std.debug.print("{d} {d} {d}\n", .{ v[0], v[1], v[2] });
}

test "length of vector" {
    const u = @Vector(3, f64){ 3, 0, 4 };
    try testing.expectEqual(length(u), 5);
}

test "cross product" {
    const u = @Vector(3, f64){ 1, 2, 3 };
    const v = @Vector(3, f64){ 2, 3, 4 };
    const c = cross(u, v);

    try testing.expectEqual(c[0], -1);
    try testing.expectEqual(c[1], 2);
    try testing.expectEqual(c[2], -1);
}
