
        function calcularTarifa() {
    let tempo = parseInt(document.getElementById('Tempo').value);
    let tamanho = document.getElementById('tamanho').value;
    let fidelidade = document.getElementById("fidelidade").value;
    let tarifa = 0;
    
    // Lógica de cobrança
    if (tempo >= 24) {
        // Se >= 24h: cobrar R$ 60 por cada período de 24h + horas excedentes
        let dias = Math.floor(tempo / 24);  // Quantos dias completos
        let horasExcedentes = tempo % 24;    // Horas que sobraram
        
        tarifa = (dias * 60) + (horasExcedentes * 2.5);
    } else if (tempo > 0) {
        // Se < 24h: R$ 5 de base + R$ 2.50 por hora
        tarifa = 5 + ((tempo * 2.5) - 2.5);
    }
    
    // Aplicar taxa para carro grande
    if (tamanho === 'Grande') {
        tarifa *= 1.25;  // 25% a mais
    }
    
    // Aplicar desconto para cliente frequente
    if (fidelidade === 'sim') {
        tarifa *= 0.95;  // 5% de desconto
    }
    
    // Mostrar resultado
    document.getElementById('resultado').textContent = 'Tarifa: R$ ' + tarifa.toFixed(2);
}
