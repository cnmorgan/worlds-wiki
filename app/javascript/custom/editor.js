import CodeMirror from 'codemirror/lib/codemirror.js'
import 'codemirror/mode/markdown/markdown.js'

function initialize(){
    let textArea = document.getElementById('page_edit_content')
    let editor = document.getElementById('content-editor')

    if(textArea && !editor){
        var contentEditor = CodeMirror.fromTextArea(textArea, {
                                                    lineWrapping: true,
                                                    mode: "markdown",
                                                });

        contentEditor.display.wrapper.id = "content-editor"
    }

    textArea = null
    editor = null

    textArea = document.getElementById('page_content')
    editor = document.getElementById("new-content-editor")

    if(textArea && !editor){
        var contentEditor = CodeMirror.fromTextArea(textArea, {
            lineWrapping: true,
            mode: "markdown",
        });

        contentEditor.display.wrapper.id = "new-content-editor"
    }
}

export {initialize}