const flights = [
    ['1234', 'New York', 'Los Angeles', '$200'],
    ['1235', 'Chicago', 'Miami', '$200'],
    ['1236', 'Seattle', 'Denver', '$200']
]


const tbody = document.querySelector('#flights-table tbody');
tbody.replaceChildren();


for (const flight of flights) {
    const row = tbody.insertRow();
    for(const value of flight) {
        row.insertCell().textContent = value;
    }
}