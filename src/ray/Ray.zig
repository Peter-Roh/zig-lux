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
    return self.orig + vec.scalar(self.dir, t);
}

pub fn ray_color(self: Self) color.Color {
    if (hit_sphere(self, point3{ 0, 0, -1 }, 0.5)) {
        return color.Color{ 1, 0, 0 };
    }

    const unit_direction = vec.unitVector(self.direction());
    const t = 0.5 * (unit_direction[1] + 1.0);
    return vec.scalar(color.Color{ 1.0, 1.0, 1.0 }, 1.0 - t) + vec.scalar(color.Color{ 0.5, 0.7, 1.0 }, t);
}

pub fn hit_sphere(self: Self, center: point3, radius: f64) bool {
    const oc = self.orig - center;
    const a = vec.dot(self.direction(), self.dir);
    const b = 2.0 * vec.dot(oc, self.direction());
    const c = vec.dot(oc, oc) - radius * radius;
    const discriminant = b * b - 4 * a * c;
    return discriminant > 0;
}
