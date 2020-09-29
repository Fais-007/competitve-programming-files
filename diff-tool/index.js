#!/usr/bin/env node
var myArgs = process.argv.slice(2);
const fs = require('fs');
var colors = require('colors');

function processLineByLine() {
    try {
        var out = fs.readFileSync(myArgs[0]).toString().split('\n');
        var eout = fs.readFileSync(myArgs[1]).toString().split('\n');
        if (eout.length === out.length) {
            for (var i = 0; i < out.length - 1; ++i) {
                if (out[i] === eout[i])
                    console.log(
                        out[i].bgBrightGreen.black +
                            ' ' +
                            eout[i].bgBrightGreen.black
                    );
                else
                    console.log(
                        out[i].bgBrightRed.black +
                            ' ' +
                            eout[i].bgBrightRed.black
                    );
            }
        } else if (eout.length > out.length) {
            for (var i = 0; i < out.length; ++i) {
                if (out[i] === eout[i])
                    console.log(
                        out[i].bgBrightGreen.black +
                            ' ' +
                            eout[i].bgBrightGreen.black
                    );
                else
                    console.log(
                        out[i].bgBrightRed.black +
                            ' ' +
                            eout[i].bgBrightRed.black
                    );
            }
            for (var j = i; j < eout.length; ++j) {
                console.log(
                    '%'.bgBrightRed.black + ' ' + eout[j].bgBrightRed.black
                );
            }
        } else {
            for (var i = 0; i < eout.length; ++i) {
                if (out[i] === eout[i])
                    console.log(
                        out[i].bgBrightGreen.black +
                            ' ' +
                            eout[i].bgBrightGreen.black
                    );
                else
                    console.log(
                        out[i].bgBrightRed.black +
                            ' ' +
                            eout[i].bgBrightRed.black
                    );
            }
            for (var j = i; j < out.length; ++j)
                console.log(
                    out[j].bgBrightRed.black + ' ' + '%'.bgBrightRed.black
                );
        }
    } catch (e) {
        console.log('Error reading files.');
    }
}

processLineByLine();
