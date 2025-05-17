window.onload = function () {
    fetchReservasPorMes();
};

function fetchReservasPorMes() {
    fetch(contextPath + '/AdminServlet?tipo=reservasPorMes')
        .then(response => {
            if (!response.ok) {
                throw new Error("Error en la respuesta del servidor");
            }
            return response.json();
        })
        .then(data => {
            const labels = data.map(item => item.mes);
            const valores = data.map(item => item.total);

            const ctx = document.getElementById('reservasPorMesChart').getContext('2d');
            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: [{
                        label: 'Plazas reservadas por mes',
                        data: valores,
                        backgroundColor: 'rgba(58, 144, 151, 1)',
                        borderColor: 'rgba(58, 144, 151, 1)',
                        borderWidth: 1
                    }]
                },
                options: {
                    responsive: true,
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        })
        .catch(error => {
            console.error("Error al obtener los datos del gráfico:", error);
        });
}
