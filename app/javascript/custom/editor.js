import CodeMirror from 'codemirror/lib/codemirror.js'
import 'codemirror/lib/codemirror.css'
import 'codemirror/mode/markdown/markdown.js'

function initialize(){
    let textEditor = document.getElementById('page_edit_content')
    let editor = document.getElementById('content-editor')
    if(textEditor && !editor){
        var contentEditor = CodeMirror.fromTextArea(textEditor, {
                                                    lineWrapping: true,
                                                    mode: "markdown",
                                                });

        contentEditor.display.wrapper.id = "content-editor"
    }
    textEditor = document.getElementById('page_edit_summary')
    editor = document.getElementById("summary-editor")
    if(textEditor && !editor){
        var contentEditor = CodeMirror.fromTextArea(textEditor, {
            lineWrapping: true,
            mode: "markdown",
        });

        contentEditor.display.wrapper.id = "summary-editor"
    }
}

export {initialize}