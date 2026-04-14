/**
 * Estacionamento v2 — Cálculo por check-in / check-out
 *
 * Recursos de Data utilizados:
 *  - new Date(string)  → converte o valor de datetime-local em objeto Date
 *  - date2 - date1     → subtração retorna a diferença em milissegundos
 *  - Math.ceil()       → arredonda as horas para cima (cobrança por hora iniciada)
 *
 * Referência: MDN Web Docs — Date
 *   https://developer.mozilla.org/pt-BR/docs/Web/JavaScript/Reference/Global_Objects/Date
 */

function calcularTarifa() {
  // ── 1. Ler e validar as datas ─────────────────────────────────────────────
  const valorEntrada = document.getElementById('checkin').value;
  const valorSaida   = document.getElementById('checkout').value;

  if (!valorEntrada || !valorSaida) {
    mostrarErro('Por favor, informe a data/hora de entrada e saída.');
    return;
  }

  // new Date() aceita o formato "YYYY-MM-DDTHH:mm" gerado pelo datetime-local
  const dtEntrada = new Date(valorEntrada);
  const dtSaida   = new Date(valorSaida);

  if (dtSaida <= dtEntrada) {
    mostrarErro('A data/hora de saída deve ser posterior à de entrada.');
    return;
  }

  // ── 2. Calcular horas ────────────────────────────────────────────────────
  //  A subtração de dois objetos Date retorna a diferença em milissegundos.
  //  Dividimos por (1000 ms × 60 s × 60 min) para converter em horas.
  //  Math.ceil garante que qualquer fração de hora seja cobrada como hora cheia.
  const diferencaMs = dtSaida - dtEntrada;                    // milissegundos
  const diferencaMin = diferencaMs / (1000 * 60);             // minutos
  const horas = Math.ceil(diferencaMin / 60);                 // horas (arredondado para cima)

  // ── 3. Lógica de tarifação ────────────────────────────────────────────────
  let tarifa = 0;

  if (horas >= 24) {
    // Se >= 24h: R$ 60 por cada período de 24h + horas excedentes
    const dias             = Math.floor(horas / 24);
    const horasExcedentes  = horas % 24;
    tarifa = (dias * 60) + (horasExcedentes * 2.5);
  } else if (horas > 0) {
    // Se < 24h: R$ 5 de base + R$ 2,50 por hora
    tarifa = 5 + ((horas * 2.5) - 2.5);
  }

  // ── 4. Acréscimo para carro grande (+25%) ─────────────────────────────────
  const tamanho = document.getElementById('tamanho').value;
  if (tamanho === 'Grande') {
    tarifa *= 1.25;
  }

  // ── 5. Desconto para cliente frequente (−5%) ──────────────────────────────
  const fidelidade = document.getElementById('fidelidade').value;
  if (fidelidade === 'sim') {
    tarifa *= 0.95;
  }

  // ── 6. Exibir resultado ───────────────────────────────────────────────────
  const duracao    = formatarDuracao(diferencaMs);
  const desconto   = fidelidade === 'sim' ? '<span class="tag desconto">5% de desconto aplicado</span>' : '';
  const taxaGrande = tamanho === 'Grande'  ? '<span class="tag acrescimo">+25% carro grande</span>'     : '';

  document.getElementById('resultado').innerHTML = `
    <div class="resultado-detalhe">
      <span class="label-res">⏱ Permanência</span>
      <span class="valor-res">${duracao}</span>
    </div>
    <div class="resultado-detalhe">
      <span class="label-res">🕐 Horas cobradas</span>
      <span class="valor-res">${horas}h</span>
    </div>
    <div class="tags">${taxaGrande}${desconto}</div>
    <div class="total">
      💰 Total: R$ ${tarifa.toFixed(2)}
    </div>
  `;
}

// ── Funções auxiliares ──────────────────────────────────────────────────────

/**
 * Formata a diferença em ms para "X dia(s) Yh Zm"
 */
function formatarDuracao(ms) {
  const totalMin = Math.floor(ms / (1000 * 60));
  const dias     = Math.floor(totalMin / (60 * 24));
  const horas    = Math.floor((totalMin % (60 * 24)) / 60);
  const minutos  = totalMin % 60;

  const partes = [];
  if (dias    > 0) partes.push(`${dias} dia${dias > 1 ? 's' : ''}`);
  if (horas   > 0) partes.push(`${horas}h`);
  if (minutos > 0) partes.push(`${minutos}min`);

  return partes.length > 0 ? partes.join(' ') : 'menos de 1 minuto';
}

/**
 * Exibe mensagem de erro no campo resultado
 */
function mostrarErro(mensagem) {
  document.getElementById('resultado').innerHTML =
    `<div class="erro">⚠️ ${mensagem}</div>`;
}
