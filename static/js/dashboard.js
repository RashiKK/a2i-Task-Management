document.addEventListener("DOMContentLoaded", function () {
    // Date Display
    const dateElement = document.getElementById("current-date");
    const currentDate = new Date().toLocaleDateString("en-US", { year: 'numeric', month: 'long', day: 'numeric' });
    dateElement.textContent = currentDate;

    // Data from the backend for the graphs
    const sources = JSON.parse(document.getElementById('source-data').textContent);
    const supports = JSON.parse(document.getElementById('support-data').textContent);
    const incidents = JSON.parse(document.getElementById('incident-data').textContent);

    // Debug: Log the received data to the browser console
    console.log("Source Data:", sources);
    console.log("Support Data:", supports);
    console.log("Incident Data:", incidents);

    // Extracting labels and counts for Source, Support Category, and Incident
    const sourceLabels = Object.keys(sources);
    const sourceCounts = Object.values(sources);

    const supportLabels = Object.keys(supports);
    const supportCounts = Object.values(supports);

    const incidentLabels = Object.keys(incidents);
    const incidentCounts = Object.values(incidents);

    // Debug: Log the labels and counts
    console.log("Source Labels:", sourceLabels);
    console.log("Source Counts:", sourceCounts);

    console.log("Support Labels:", supportLabels);
    console.log("Support Counts:", supportCounts);

    console.log("Incident Labels:", incidentLabels);
    console.log("Incident Counts:", incidentCounts);

    // Source Bar Chart
    const sourceCtx = document.getElementById("sourceChart").getContext("2d");
    new Chart(sourceCtx, {
        type: 'bar',
        data: {
            labels: sourceLabels,
            datasets: [{
                label: "Source Categories",
                data: sourceCounts,
                backgroundColor: "#36a2eb", // Light blue for the bars
                borderColor: "#007bff", // Darker blue for the border
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Support Category Bar Chart
    const supportCtx = document.getElementById("supportChart").getContext("2d");
    new Chart(supportCtx, {
        type: 'bar',
        data: {
            labels: supportLabels,
            datasets: [{
                label: "Support Categories",
                data: supportCounts,
                backgroundColor: "#ff9f40", // Orange for the bars
                borderColor: "#ff6384", // Red border
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Incident Bar Chart
    const incidentCtx = document.getElementById("incidentChart").getContext("2d");
    new Chart(incidentCtx, {
        type: 'bar',
        data: {
            labels: incidentLabels,
            datasets: [{
                label: "Incident Categories",
                data: incidentCounts,
                backgroundColor: "#4bc0c0", // Light teal for the bars
                borderColor: "#36a2eb", // Dark teal for the border
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                y: {
                    beginAtZero: true
                }
            }
        }
    });

    // Update total numbers for each category
    document.getElementById("total-sources").textContent = sourceCounts.reduce((a, b) => a + b, 0);
    document.getElementById("total-support").textContent = supportCounts.reduce((a, b) => a + b, 0);
    document.getElementById("total-incidents").textContent = incidentCounts.reduce((a, b) => a + b, 0);
});
