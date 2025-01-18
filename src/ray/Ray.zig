const std = @import("std");
const vec = @import("../vec/vec.zig");
const color = @import("../color/Color.zig");

pub const point3 = vec.Vec3;
const Vec3 = vec.Vec3;

const Self = @This();

orig: point3,
dir: Vec3,

pub fn init(orig: point3, dir: Vec3) Self {
    return Self{
        .orig = orig,
        .dir = dir,
    };
}

pub fn origin(self: Self) point3 {
    return self.orig;
}

pub fn direction(self: Self) Vec3 {
    return self.dir;
}

pub fn at(self: Self, t: f64) point3 {
    return self.orig + t * self.dir;
}

pub fn ray_color(self: Self) color.Color {
    const unit_direction = vec.unitVector(self.direction());
    const t = 0.5 * (unit_direction[1] + 1.0);
    return Vec3{ 1.0 - t, 1.0 - t, 1.0 - t } * color.Color{ 1.0, 1.0, 1.0 } + Vec3{ t, t, t } * color.Color{ 0.5, 0.7, 1.0 };
}
