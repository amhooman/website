/**
 * By @andylolz
 * https://github.com/andylolz/ultimate-tic-tac-toe
 *
 * code heavily based upon:
 * https://github.com/josephwegner/node-tac-toe
 */
$(document).ready(function() {
    // click listener
    $(".little_table").find("td:not(.filled)").click(function() {
        if($(this).closest('.live').length === 0) {
            // the clicked td wasn't live
            return;
        }

        // whose turn is it?
        var colour = $("#turn").hasClass("red") ? "red" : "blue";

        // get a few useful jquery objects
        little_table = $(this).closest('.little_table');
        little_col = $(this).attr('class');
        little_row = $(this).closest('tr').attr('class');

        // we use this a couple of times
        little_pos = '.col-' + little_col + '.row-' + little_row;

        // update the 'live' yellow box
        $(".live").removeClass('live');
        if($(".little_table" + little_pos + " td").not('.filled').length === 0) {
            // that board is full, so it's a free-for-all!
            $(".big_table").addClass('live');
        } else {
            // update the live board
            $(".little_table" + little_pos).addClass('live');
        }

        var div = $("<div>").addClass("marker").addClass(colour).addClass('col-' + little_col).addClass('row-' + little_row);
        $(this).html(div); // add the marker
        $(this).addClass("filled"); // mark the td as filled
        $(this).unbind("click"); // prevent this td being clicked again

        markers = little_table.find(".marker").filter("." + colour);

        if(threeInRow(markers) || threeInColumn(markers) || threeInDiagonal(markers)) {
            // mark this board as won
            little_table.addClass(colour);
            if(colour === 'red') {
                // add a feint red bg.
                // Classes mess other stuff up, so this is the easiest way to do it
                little_table.find('td').css('backgroundColor', '#ffaaaa');
            } else {
                // add a feint blue bg
                little_table.find('td').css('backgroundColor', '#aaaaff');
            }
        }

        // repeat the above, but for the big board
        markers = $('.little_table').filter("." + colour);

        if(threeInRow(markers) || threeInColumn(markers) || threeInDiagonal(markers)) {
            // hooray!
            win();
        } else {
            if($("td").not('.filled').length === 0) {
                // wow - what a boring game!
                $("#turn").fadeOut(500, function() {
                    showNewGame();
                });
            } else {
                // switch turns
                $("#turn").removeClass(colour).addClass((colour === "red") ? "blue" : "red");
                $("#turn").html(((colour === "red") ? "Blue" : "Red") + "&rsquo;s turn&hellip;");
            }
        }
    });
});

function win() {
    var curTop = $("#turn").offset().top;
    var top = $(".big_table").position().top;
    var left = $(".big_table").offset().left;

    $("#turn").css({
        "position": "absolute",
        "left": left + "px",
        "top": curTop + "px"
    });

    $("#turn").text("");

    $("#turn").animate({
        top: top + "px",
        height: "560px",
        opacity: 0.85
    }, 500, function() {
        showNewGame();
    });
}

function showNewGame() {
    $("#newGame").css('display', 'block').hide().fadeIn(500);
}

function threeInRow(markers) {
       return (($(markers).filter(".row-1").length === 3) || ($(markers).filter(".row-2").length === 3) || ($(markers).filter(".row-3").length === 3));
}

function threeInColumn(markers) {
       return (($(markers).filter(".col-1").length === 3) || ($(markers).filter(".col-2").length === 3) || ($(markers).filter(".col-3").length === 3));
}

function threeInDiagonal(markers) {
    //No middle marker
    if($(markers).filter(".col-2").filter(".row-2").length === 0) {
        return false;
    }

    if($(markers).filter(".col-1").filter(".row-1").length === 1 && $(markers).filter(".col-3").filter(".row-3").length === 1) {
        return true;
    }

    if($(markers).filter(".col-1").filter(".row-3").length === 1 && $(markers).filter(".col-3").filter(".row-1").length === 1) {
        return true;
    }

    return false;
}