// SPDX-License-Identifier: MIT
// UnFlock Authors: see AUTHORS.txt

use crate::graph_generator::*;
use crate::math::*;
use bevy::math::Vec3;

#[test]
fn test_vec2i_equal() {
    let p1 = Vec2i { x: -255, y: 390 };
    let p2 = Vec2i { x: -255, y: 390 };

    assert!(p1 == p2, "points should be equal");
}

#[test]
fn test_from_vertices() {
    let p1 = Vec2i { x: 0, y: 0 };
    let p2 = Vec2i { x: 1, y: 1 };

    let line = LineSegment::from((&p1, &p2));

    assert_eq!(1, line.a_x(), "a does not match");
    assert_eq!(-1, line.b_y(), "b does not match");
    assert_eq!(0, line.c(), "c does not match");
}

#[test]
fn test_from_vertices_rounding() {
    let p1 = Vec3::new(1.3, 1.5, 0.);
    let p2 = Vec3::new(1.7, 1.9, 0.);

    let line = LineSegment::from((&p1, &p2));

    assert_eq!(1, line.start().x, "from.x should be 1");
    assert_eq!(2, line.start().y, "from.y should be 2");
    assert_eq!(2, line.end().x, "to.x should be 2");
    assert_eq!(2, line.end().y, "to.y should be 2");
}

#[test]
fn test_from_vertices_parallel_to_y() {
    let p1 = Vec2i { x: 225, y: 390 };
    let p2 = Vec2i { x: 225, y: -390 };

    let line = LineSegment::from((&p1, &p2));

    assert_eq!(-780, line.a_x(), "a does not match");
    assert_eq!(0, line.b_y(), "b does not match");
    assert_eq!(175500, line.c(), "c does not match");

    assert_eq!(0, line.distance_of(&p1), "p1 distance should be 0");
    assert_eq!(0, line.distance_of(&p2), "p2 distance should be 0");
}

#[test]
fn test_from_vertices_parallel_to_x() {
    let p1 = Vec2i { x: 225, y: 390 };
    let p2 = Vec2i { x: -225, y: 390 };

    let line = LineSegment::from((&p1, &p2));

    assert_eq!(0, line.a_x(), "a does not match");
    assert_eq!(450, line.b_y(), "b does not match");
    // is this value correct?
    assert_eq!(-175500, line.c(), "c does not match");

    assert_eq!(0, line.distance_of(&p1), "p1 distance should be 0");
    assert_eq!(0, line.distance_of(&p2), "p2 distance should be 0");
}

#[test]
fn test_segment_intersect_cross() {
    let l1_p1 = Vec2i { x: 3, y: 3 };
    let l1_p2 = Vec2i { x: -3, y: -3 };

    let l2_p1 = Vec2i { x: 3, y: -3 };
    let l2_p2 = Vec2i { x: -3, y: 3 };

    let line_1 = LineSegment::from((&l1_p1, &l1_p2));
    let line_2 = LineSegment::from((&l2_p1, &l2_p2));

    let intersect = line_1.intersect_segments(&line_2);
    assert!(intersect.is_some(), "missing intersection");
    let intersect = intersect.unwrap();
    assert_eq!(0, intersect.x, "missing intersection");
    assert_eq!(0, intersect.y, "missing intersection");
}

#[test]
fn test_segment_no_intersect() {
    let l1_p1 = Vec2i { x: 3, y: 3 };
    let l1_p2 = Vec2i { x: -3, y: -3 };

    let l2_p1 = Vec2i { x: 3, y: 3 };
    let l2_p2 = Vec2i { x: -3, y: 3 };

    let line_1 = LineSegment::from((&l1_p1, &l1_p2));
    let line_2 = LineSegment::from((&l2_p1, &l2_p2));

    let intersect = line_1.intersect_segments(&line_2);
    assert!(intersect.is_none(), "should not intersect");
}

#[test]
fn test_segments_no_intersect() {
    let l1_p1 = Vec2i { x: 3, y: 3 };
    let l1_p2 = Vec2i { x: 2, y: 0 };

    let l2_p1 = Vec2i { x: -3, y: -3 };
    let l2_p2 = Vec2i { x: -2, y: 0 };

    let line_1 = LineSegment::from((&l1_p1, &l1_p2));
    let line_2 = LineSegment::from((&l2_p1, &l2_p2));

    let intersect = line_1.intersect_segments(&line_2);
    assert!(intersect.is_none(), "should not intersect");
}

#[test]
fn test_segments_are_colinear() {
    let l1_p1 = Vec2i { x: 3, y: 3 };
    let l1_p2 = Vec2i { x: -3, y: 3 };

    let l2_p1 = Vec2i { x: 3, y: 3 };
    let l2_p2 = Vec2i { x: -3, y: 3 };

    let line_1 = LineSegment::from((&l1_p1, &l1_p2));
    let line_2 = LineSegment::from((&l2_p1, &l2_p2));

    let intersect = line_1.intersect_segments(&line_2);
    assert!(intersect.is_none(), "should not intersect");
    assert!(intersect.is_colinear(), "should be colinear");
}

#[test]
fn test_segment_no_intersect_parallel() {
    let l1_p1 = Vec2i { x: -1, y: -1 };
    let l1_p2 = Vec2i { x: 1, y: 1 };

    let l2_p1 = Vec2i { x: -1, y: -1 };
    let l2_p2 = Vec2i { x: 1, y: 1 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(
        intersection.is_none(),
        "parallel lines should not intersect"
    );
}

#[test]
fn test_intersect_at_origin() {
    let l1_p1 = Vec2i { x: -1, y: -1 };
    let l1_p2 = Vec2i { x: 1, y: 1 };

    let l2_p1 = Vec2i { x: -1, y: 1 };
    let l2_p2 = Vec2i { x: 1, y: -1 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(
        intersection.is_some(),
        "there should be an intersection at 0/0/0"
    );
    let intersection = intersection.unwrap();
    assert_eq!(
        Intersect { x: 0, y: 0 },
        intersection,
        "there should be an intersection at 0/0/0"
    );
}

#[test]
fn test_no_intersect_same_endpoint() {
    let l1_p1 = Vec2i { x: 0, y: 0 };
    let l1_p2 = Vec2i { x: 1, y: 1 };

    let l2_p1 = Vec2i { x: 0, y: 0 };
    let l2_p2 = Vec2i { x: 1, y: -1 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(
        intersection.is_none(),
        "there should not be an intersection"
    );
}

#[test]
fn test_intersect_almost_parallel() {
    let l1_p1 = Vec2i { x: 100, y: 1 };
    let l1_p2 = Vec2i { x: -100, y: -1 };

    let l2_p1 = Vec2i { x: 100, y: 0 };
    let l2_p2 = Vec2i { x: -100, y: 0 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(
        intersection.is_some(),
        "there should be an intersection at 0/0/0"
    );
}

#[test]
fn test_intersect_graph_7_1() {
    let l1_p1 = Vec2i { x: -225, y: 390 };
    let l1_p2 = Vec2i { x: 225, y: -390 };

    let l2_p1 = Vec2i { x: -255, y: 390 };
    let l2_p2 = Vec2i { x: 450, y: 0 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(intersection.is_some(), "there should be an intersection");
}

#[test]
fn test_intersect_graph_7_2() {
    let l1_p1 = Vec2i { x: -225, y: 390 };
    let l1_p2 = Vec2i { x: 225, y: -300 };

    let l2_p1 = Vec2i { x: -225, y: -390 };
    let l2_p2 = Vec2i { x: 450, y: 0 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(intersection.is_some(), "there should be an intersection");
}

#[test]
fn test_intersect_graph_7_3() {
    let l1_p1 = Vec2i { x: -225, y: 390 };
    let l1_p2 = Vec2i { x: 225, y: -390 };

    let l2_p1 = Vec2i { x: -450, y: -0 };
    let l2_p2 = Vec2i { x: 225, y: 390 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(intersection.is_some(), "there should be an intersection");
}

#[test]
fn test_intersect_graph_6_1() {
    let l1_p1 = Vec2i { x: -225, y: -390 };
    let l1_p2 = Vec2i { x: 225, y: -390 };

    let l2_p1 = Vec2i { x: -450, y: -0 };
    let l2_p2 = Vec2i { x: 225, y: 390 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(intersection.is_none(), "there should be an intersection");
}

#[test]
fn test_intersect_graph_5_1() {
    let l1_p1 = Vec2i { x: 225, y: 390 };
    let l1_p2 = Vec2i { x: 225, y: -390 };

    let l2_p1 = Vec2i { x: -225, y: 390 };
    let l2_p2 = Vec2i { x: 450, y: 0 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(intersection.is_some(), "there should be an intersection");
}

#[test]
fn test_intersect_graph_5_2() {
    let l1_p1 = Vec2i { x: 225, y: 390 };
    let l1_p2 = Vec2i { x: 225, y: -390 };

    let l2_p1 = Vec2i { x: -225, y: -390 };
    let l2_p2 = Vec2i { x: 450, y: 0 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(intersection.is_some(), "there should be an intersection");
}

#[test]
fn test_intersect_graph_4_1() {
    let l1_p1 = Vec2i { x: -450, y: -0 };
    let l1_p2 = Vec2i { x: 225, y: 390 };

    let l2_p1 = Vec2i { x: -225, y: 390 };
    let l2_p2 = Vec2i { x: 450, y: 0 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(intersection.is_some(), "there should be an intersection");
}

#[test]
fn test_segment_intersect_in_out() {
    let l1_p1 = Vec2i { x: 50, y: 0 };
    let l1_p2 = Vec2i { x: 20, y: 20 };

    let l2_p1 = Vec2i { x: 20, y: 20 };
    let l2_p2 = Vec2i { x: 40, y: 40 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(
        intersection.is_none(),
        "there should not be an intersection (inward)"
    );

    let l3_p1 = Vec2i { x: 60, y: 20 };
    let l3_p2 = Vec2i { x: 40, y: 40 };

    let intersection2 = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l3_p1, &l3_p2)));

    assert!(
        intersection2.is_none(),
        "there should not be an intersection (outward)"
    );
}

#[test]
fn test_segment_should_not_intersect_1() {
    let l1_p1 = Vec2i { x: 225, y: 390 };
    let l1_p2 = Vec2i { x: 270, y: 180 };

    let l2_p1 = Vec2i { x: 450, y: 0 };
    let l2_p2 = Vec2i { x: 208, y: -246 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));

    assert!(
        intersection.is_none(),
        "there should not be an intersection"
    );
    assert_eq!(
        SegmentIntersectionType::None,
        intersection,
        "there should not be an intersection"
    );
}

#[test]
fn test_segment_should_not_intersect_2() {
    let l1_p1 = Vec2i { x: 225, y: 390 };
    let l1_p2 = Vec2i { x: 270, y: 180 };

    let l2_p1 = Vec2i { x: 450, y: 0 };
    let l2_p2 = Vec2i { x: -225, y: -390 };

    let intersection = LineSegment::from((&l1_p1, &l1_p2))
        .intersect_segments(&LineSegment::from((&l2_p1, &l2_p2)));
    println!("Hello World");

    assert!(
        intersection.is_none(),
        "there should not be an intersection"
    );
    assert_eq!(
        SegmentIntersectionType::None,
        intersection,
        "there should not be an intersection"
    );
}

#[test]
fn test_lines_are_parallel() {
    let l1_p1 = Vec2i { x: 3, y: 3 };
    let l1_p2 = Vec2i { x: -3, y: 3 };

    let l2_p1 = Vec2i { x: 3, y: 0 };
    let l2_p2 = Vec2i { x: -3, y: 0 };

    let line_1 = LineSegment::from((&l1_p1, &l1_p2));
    let line_2 = LineSegment::from((&l2_p1, &l2_p2));

    let intersect = line_1.intersect_lines(&line_2);
    assert!(intersect.is_none(), "lines should be parallel");
}

#[test]
fn test_same_sign() {
    assert_eq!(true, i32::MIN.same_sign(i32::MIN), "sign should be same");
    assert_eq!(
        false,
        i32::MIN.same_sign(i32::MAX),
        "sign should be different"
    );
    assert_eq!(
        false,
        i32::MAX.same_sign(i32::MIN),
        "sign should be different"
    );
    assert_eq!(true, i32::MAX.same_sign(i32::MAX), "sign should be same");
}
