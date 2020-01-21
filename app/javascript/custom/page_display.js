

function formatToc(){
    let toc = document.getElementById("markdown-toc")
    let tocRow = document.getElementById("toc-row")
    
    if(toc && !tocRow){
        let row = document.createElement('div')
        row.className = "row"
        row.id = "toc-row"
        let pageNav = document.createElement('div')
        pageNav.className = 'page-nav'
        let contentSpan = document.createElement('div')
        contentSpan.className = "page-nav-title"
        contentSpan.innerHTML = "Content"
    
        toc.parentNode.insertBefore(row, toc);
        row.appendChild(pageNav);
        pageNav.appendChild(contentSpan);
        pageNav.appendChild(toc);
    }
}

export {formatToc}
