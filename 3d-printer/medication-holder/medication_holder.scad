include <src/core/standard.scad>
use <src/core/gridfinity-rebuilt-utility.scad>
use <src/core/gridfinity-rebuilt-holes.scad>
use <src/core/bin.scad>
use <src/core/cutouts.scad>
use <src/helpers/generic-helpers.scad>
use <src/helpers/grid.scad>
use <src/helpers/grid_element.scad>

// --- Parameters ---
gridx = 4; // 168mm
gridy = 2; // 84mm
gridz = 6; // 42mm high

strip_width = 55;   // Width of medication strip (along Y)
strip_thickness = 4; // Thickness of the slot
slot_depth = 35;    // How deep the slots go
wall = 1.5;         // Wall thickness between slots
gap_between_sections = 4; 

label_slot_depth = 10;
label_slot_thick = 1.5;

bin1 = new_bin(
    grid_size = [gridx, gridy],
    height_mm = height(gridz, 0, false),
    fill_height = 0,
    include_lip = true,
    hole_options = bundle_hole_options(true, false, false, false, false, true)
);

bin_render(bin1) {
    depth = bin_get_infill_size_mm(bin1).z;
    
    // We start from left (X=0) and go right.
    // X center of the grid base is at 0,0 in new_bin? 
    // Actually in gridfinity-rebuilt, the center of the bin is [0,0,0], let's check.
    // In gridfinity-rebuilt-utility, gridfinityBase is centered at 0,0 or corner?
    // Let's assume the center is at [0,0] for the whole bin, which is typical for bin_render cutters.
    
    // Wait, let's just make the cutouts relative to the center of the bin: X from -gridx*21 to +gridx*21.
    
    // Total width of all slots:
    // 4 sections of 3 slots = 4 * (3*4 + 4*1.5) = 4 * 18 = 72mm
    // 1 unique section of 12 slots = 12*4 + 13*1.5 = 67.5mm
    // Total = 139.5 mm + 4 gaps of 4mm (16mm) = 155.5 mm.
    // This perfectly fits inside 168mm!
    
    start_x = -gridx*21 + (gridx*42 - 155.5)/2; // center it
    y_pos = 10; // offset slightly back to leave room for label
    
    // Section 1 to 4
    for (sec = [0:3]) {
        sec_x = start_x + sec * (3*(strip_thickness+wall) + gap_between_sections);
        for (i = [0:2]) {
            slot_x = sec_x + wall + strip_thickness/2 + i*(strip_thickness+wall);
            translate([slot_x, y_pos, -depth + (depth - slot_depth)])
                cube([strip_thickness, strip_width, slot_depth * 2], center=true);
        }
        // Label slot for this section
        translate([sec_x + (3*(strip_thickness+wall))/2, y_pos - strip_width/2 - 5, -depth + (depth - label_slot_depth)])
            cube([3*(strip_thickness+wall) - 2, label_slot_thick, label_slot_depth*2], center=true);
    }
    
    // Unique Section (12 slots)
    sec_5_x = start_x + 4 * (3*(strip_thickness+wall) + gap_between_sections);
    for (i = [0:11]) {
        slot_x = sec_5_x + wall + strip_thickness/2 + i*(strip_thickness+wall);
        translate([slot_x, y_pos, -depth + (depth - slot_depth)])
            cube([strip_thickness, strip_width, slot_depth * 2], center=true);
            
        // Individual label slot for each unique medication
        translate([slot_x, y_pos - strip_width/2 - 5, -depth + (depth - label_slot_depth)])
            cube([strip_thickness+0.5, label_slot_thick, label_slot_depth*2], center=true);
    }
}
