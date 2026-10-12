/*
 * MultipleRotate.jsx
 *
 * AIP Mirror — 01A — JSX Prototype
 *
 * Minimal behavioral prototype for the FreeHand MX-inspired
 * Multiple / Rotate operation.
 *
 * Scope:
 *   - Multiple mode only
 *   - Rotate mode only
 *   - Source object is preserved
 *   - Multiple = total number of objects, including the source
 *   - Copies are evenly distributed around a user-defined center
 *
 * Not implemented:
 *   - Reflect mode
 *   - Close Paths
 *   - Snapping
 *   - Interactive mouse dragging
 *   - Modifier keys
 */

(function () {
    function isFiniteNumber(value) {
        return typeof value === "number" && isFinite(value);
    }

    function parseNumber(text) {
        var value = Number(text);
        return isFiniteNumber(value) ? value : null;
    }

    function formatNumber(value) {
        return String(Math.round(value * 1000) / 1000);
    }

    function getSelectedPageItem() {
        if (!app.documents.length) {
            throw new Error("No Illustrator document is open.");
        }

        if (app.activeDocument.selection.length !== 1) {
            throw new Error("Please select exactly one object.");
        }

        var item = app.activeDocument.selection[0];

        if (!item || typeof item.duplicate !== "function") {
            throw new Error("The selected object cannot be duplicated.");
        }

        return item;
    }

    /*
     * Illustrator visibleBounds:
     * [left, top, right, bottom]
     *
     * Used only for the dialog's default center.
     */
    function getDefaultCenter(item) {
        var bounds = item.visibleBounds;

        return {
            x: (bounds[0] + bounds[2]) / 2,
            y: (bounds[1] + bounds[3]) / 2
        };
    }

    /*
     * Multiple = total number of objects, including the source.
     *
     * Example:
     *   Multiple = 6
     *   step = 360 / 6 = 60°
     *
     * Slot 0 is the untouched source.
     * Generated copies use slots 1 ... N-1.
     */
    function getRotationAngle(index, multiple) {
        return (360 / multiple) * index;
    }

    /*
     * Rotate a point in Illustrator's page-coordinate convention.
     *
     * This is currently a small geometry helper for the prototype.
     * The actual object transform is performed with Illustrator's
     * matrix API below.
     */
    function rotatePoint(point, center, degrees) {
        var radians = degrees * Math.PI / 180;
        var cos = Math.cos(radians);
        var sin = Math.sin(radians);

        var dx = point.x - center.x;
        var dy = point.y - center.y;

        return {
            x: center.x + dx * cos + dy * sin,
            y: center.y - dx * sin + dy * cos
        };
    }

    /*
     * Apply a rotation around an arbitrary document point.
     *
     * The matrix is:
     *
     *   T(C) * R * T(-C)
     *
     * expressed in Illustrator's page-coordinate convention.
     */
    function transformCopyAroundCenter(source, center, angle) {
        var copy = source.duplicate();

        var radians = angle * Math.PI / 180;
        var cos = Math.cos(radians);
        var sin = Math.sin(radians);

        var matrix = app.getIdentityMatrix();

        matrix.mValueA = cos;
        matrix.mValueB = -sin;
        matrix.mValueC = sin;
        matrix.mValueD = cos;

        matrix.mValueTX =
            center.x - center.x * cos - center.y * sin;

        matrix.mValueTY =
            center.y + center.x * sin - center.y * cos;

        copy.transform(
            matrix,
            true,   // changePositions
            true,   // changeFillPatterns
            true,   // changeFillGradients
            true,   // changeStrokePattern
            true,   // changeLineWidths
            Transformation.CENTER
        );

        return copy;
    }

    function showDialog(defaultCenter) {
        var dialog = new Window("dialog", "Multiple Rotate");

        dialog.orientation = "column";
        dialog.alignChildren = ["fill", "top"];
        dialog.spacing = 10;
        dialog.margins = 16;

        var values = dialog.add("panel", undefined, "Multiple / Rotate");
        values.orientation = "column";
        values.alignChildren = ["fill", "top"];
        values.spacing = 8;
        values.margins = 12;

        var multipleGroup = values.add("group");
        multipleGroup.add("statictext", undefined, "Multiple:");
        var multipleInput = multipleGroup.add("edittext", undefined, "6");
        multipleInput.characters = 8;

        var centerXGroup = values.add("group");
        centerXGroup.add("statictext", undefined, "Center X:");
        var centerXInput = centerXGroup.add(
            "edittext",
            undefined,
            formatNumber(defaultCenter.x)
        );
        centerXInput.characters = 12;

        var centerYGroup = values.add("group");
        centerYGroup.add("statictext", undefined, "Center Y:");
        var centerYInput = centerYGroup.add(
            "edittext",
            undefined,
            formatNumber(defaultCenter.y)
        );
        centerYInput.characters = 12;

        var info = dialog.add(
            "statictext",
            undefined,
            "Rotate mode • source object is preserved"
        );
        info.alignment = "left";

        var buttons = dialog.add("group");
        buttons.alignment = "right";

        var cancelButton = buttons.add("button", undefined, "Cancel");
        var createButton = buttons.add("button", undefined, "Create");
        createButton.active = true;

        cancelButton.onClick = function () {
            dialog.close(0);
        };

        createButton.onClick = function () {
            var multiple = parseNumber(multipleInput.text);
            var centerX = parseNumber(centerXInput.text);
            var centerY = parseNumber(centerYInput.text);

            if (multiple === null ||
                multiple < 1 ||
                Math.floor(multiple) !== multiple) {
                alert("Multiple must be a positive whole number.");
                multipleInput.active = true;
                return;
            }

            if (centerX === null || centerY === null) {
                alert("Center X and Center Y must be valid numbers.");
                return;
            }

            dialog.result = {
                multiple: multiple,
                center: {
                    x: centerX,
                    y: centerY
                }
            };

            dialog.close(1);
        };

        return dialog;
    }

    function main() {
        var source = getSelectedPageItem();
        var defaultCenter = getDefaultCenter(source);

        var dialog = showDialog(defaultCenter);

        if (dialog.show() !== 1) {
            return;
        }

        var settings = dialog.result;
        var multiple = settings.multiple;
        var center = settings.center;

        if (multiple === 1) {
            return;
        }

        /*
         * The source remains untouched.
         * Each copy is generated from the original source so transforms
         * are absolute rather than cumulative.
         */
        for (var i = 1; i < multiple; i++) {
            var angle = getRotationAngle(i, multiple);
            transformCopyAroundCenter(source, center, angle);
        }

        alert(
            "Created " +
            multiple +
            " total objects.\n\n" +
            "Rotation step: " +
            formatNumber(360 / multiple) +
            "°"
        );
    }

    try {
        main();
    } catch (error) {
        alert("Multiple Rotate\n\n" + error.message);
    }
})();
