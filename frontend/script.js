const BASE_URL = "https://cloud-resume-api-pdevene.azurewebsites.net/api"

function incrementVisitorCount() {
    fetch(`${BASE_URL}/increment`)           
        .then(response => response.json())
        .then(data => {
            document.getElementById("visitor-count").innerHTML = "Visitor count: " + data;
        })
        .catch((err) => console.error("Something went wrong.", err));
}

window.onload = incrementVisitorCount()