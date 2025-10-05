const originSelect = document.getElementById("origin-select");
const destinationSelect = document.getElementById("destination-select");
const schedulePanel = document.getElementById("schedule-panel");
const scheduleList = document.getElementById("schedule-list");
const seatPanel = document.getElementById("seat-panel");
const selectedRouteSummary = document.getElementById("selected-route-summary");
const seatForm = document.getElementById("seat-form");
const seatCountInput = document.getElementById("seat-count");
const continueButton = document.getElementById("continue-button");
const continueButtonLabel = continueButton.textContent;
const changeRouteButton = document.getElementById("change-route");

const routeTemplate = document.getElementById("route-card-template");

const weekdayNames = [
  "Domingo",
  "Lunes",
  "Martes",
  "Miércoles",
  "Jueves",
  "Viernes",
  "Sábado",
];

const formatDate = (date) =>
  date.toLocaleDateString("es-CR", {
    day: "2-digit",
    month: "short",
  });

const routeSchedules = {
  "san-jose|alajuela": {
    duration: "1 h 10 min",
    price: 4500,
    departures: [
      { dayOffset: 1, time: "06:15", bus: "Viazy Express", extras: "Wifi + Cargadores" },
      { dayOffset: 1, time: "09:45", bus: "Viazy Express", extras: "Asientos reclinables" },
      { dayOffset: 2, time: "12:30", bus: "Rápidos del Valle", extras: "Parada directa" },
      { dayOffset: 3, time: "07:00", bus: "Viazy Flex", extras: "Pet friendly" },
      { dayOffset: 4, time: "18:00", bus: "Viazy Flex", extras: "Wifi + Snack" },
      { dayOffset: 5, time: "21:15", bus: "Nocturno Plus", extras: "Climatizado" },
      { dayOffset: 6, time: "10:45", bus: "Viazy Express", extras: "Espacio extra" },
    ],
  },
  "san-jose|limon": {
    duration: "3 h 40 min",
    price: 9500,
    departures: [
      { dayOffset: 1, time: "05:45", bus: "Caribe Premium", extras: "Wifi + Snack" },
      { dayOffset: 2, time: "08:30", bus: "Caribe Premium", extras: "Asientos reclinables" },
      { dayOffset: 3, time: "11:15", bus: "Viazy Atlántico", extras: "Climatizado" },
      { dayOffset: 4, time: "14:45", bus: "Viazy Atlántico", extras: "USB individual" },
      { dayOffset: 5, time: "17:00", bus: "Caribe Premium", extras: "Paradas cortas" },
      { dayOffset: 6, time: "19:30", bus: "Nocturno Plus", extras: "Descanso total" },
      { dayOffset: 7, time: "22:15", bus: "Nocturno Plus", extras: "Asistente a bordo" },
    ],
  },
  "san-jose|puntarenas": {
    duration: "2 h 50 min",
    price: 8200,
    departures: [
      { dayOffset: 1, time: "07:30", bus: "Pacífico Line", extras: "Wifi + Aire" },
      { dayOffset: 1, time: "13:00", bus: "Viazy Costa", extras: "Espacio extra" },
      { dayOffset: 2, time: "16:30", bus: "Pacífico Line", extras: "Snack de bienvenida" },
      { dayOffset: 3, time: "05:15", bus: "Nocturno Plus", extras: "Semi cama" },
      { dayOffset: 4, time: "09:45", bus: "Viazy Costa", extras: "Climatizado" },
      { dayOffset: 5, time: "18:15", bus: "Viazy Costa", extras: "Pet friendly" },
      { dayOffset: 6, time: "20:40", bus: "Pacífico Line", extras: "Parada gastronómica" },
    ],
  },
  "alajuela|heredia": {
    duration: "45 min",
    price: 2500,
    departures: [
      { dayOffset: 1, time: "06:10", bus: "Viazy City", extras: "Wifi + USB" },
      { dayOffset: 1, time: "07:40", bus: "Viazy City", extras: "Paradas exprés" },
      { dayOffset: 2, time: "09:30", bus: "Viazy City", extras: "Asientos acolchados" },
      { dayOffset: 3, time: "12:10", bus: "City Flex", extras: "Climatizado" },
      { dayOffset: 4, time: "15:20", bus: "City Flex", extras: "Accesible" },
      { dayOffset: 5, time: "17:50", bus: "Viazy City", extras: "Pet friendly" },
      { dayOffset: 6, time: "20:10", bus: "City Flex", extras: "Trayecto directo" },
    ],
  },
  "cartago|san-jose": {
    duration: "1 h 5 min",
    price: 4100,
    departures: [
      { dayOffset: 1, time: "06:00", bus: "Interurbano", extras: "Wifi + USB" },
      { dayOffset: 1, time: "08:00", bus: "Interurbano", extras: "Asientos reclinables" },
      { dayOffset: 2, time: "10:30", bus: "Viazy Express", extras: "Parada directa" },
      { dayOffset: 3, time: "13:00", bus: "Viazy Express", extras: "Climatizado" },
      { dayOffset: 4, time: "16:30", bus: "Ruta Verde", extras: "Carga eléctrica" },
      { dayOffset: 5, time: "18:30", bus: "Ruta Verde", extras: "Pet friendly" },
      { dayOffset: 6, time: "21:15", bus: "Nocturno Plus", extras: "Semi cama" },
    ],
  },
};

let selectedKey = null;
let selectedRoute = null;

const resetPanels = () => {
  schedulePanel.classList.remove("is-visible");
  seatPanel.classList.remove("is-visible");
  scheduleList.innerHTML = "";
  selectedRouteSummary.textContent = "";
  selectedRoute = null;
  selectedKey = null;
  continueButton.disabled = true;
};

const getKey = () => {
  const origin = originSelect.value;
  const destination = destinationSelect.value;
  if (!origin || !destination || origin === destination) {
    return null;
  }
  return `${origin}|${destination}`;
};

const populateSchedule = (key) => {
  const data = routeSchedules[key];
  if (!data) {
    scheduleList.innerHTML =
      "<p class=\"empty-state\">Pronto tendremos salidas para esta combinación. Intenta con otra ruta.</p>";
    return;
  }

  const today = new Date();
  scheduleList.innerHTML = "";

  data.departures.forEach((departure, index) => {
    const card = routeTemplate.content.firstElementChild.cloneNode(true);
    const departureDate = new Date(today);
    departureDate.setDate(today.getDate() + departure.dayOffset);

    card.querySelector(".route-card__day").textContent =
      weekdayNames[departureDate.getDay()];
    card.querySelector(".route-card__date").textContent = formatDate(departureDate);
    card.querySelector(".route-card__time").textContent = departure.time;
    card.querySelector(".route-card__bus").textContent = departure.bus;
    card.querySelector(".route-card__extras").textContent = `${data.duration} · ${departure.extras}`;

    const selectButton = card.querySelector(".select-button");
    selectButton.dataset.index = String(index);

    selectButton.addEventListener("click", () => {
      document
        .querySelectorAll(".route-card")
        .forEach((node) => node.classList.remove("is-selected"));
      card.classList.add("is-selected");
      selectedRoute = {
        key,
        ...departure,
        duration: data.duration,
        price: data.price,
        dayLabel: card.querySelector(".route-card__day").textContent,
        dateLabel: card.querySelector(".route-card__date").textContent,
      };
      updateSeatPanel();
    });

    scheduleList.appendChild(card);
  });
};

const updateSeatPanel = () => {
  if (!selectedRoute) {
    seatPanel.classList.remove("is-visible");
    continueButton.disabled = true;
    return;
  }

  selectedRouteSummary.textContent = `${selectedRoute.dayLabel} · ${selectedRoute.dateLabel} · ${selectedRoute.time} · ${selectedRoute.bus}`;
  seatPanel.classList.add("is-visible");
  continueButton.disabled = false;
};

const handleSelectionChange = () => {
  const key = getKey();
  if (!key) {
    resetPanels();
    return;
  }

  if (key === selectedKey) {
    return;
  }

  selectedKey = key;
  selectedRoute = null;
  continueButton.disabled = true;
  selectedRouteSummary.textContent = "";
  seatPanel.classList.remove("is-visible");

  populateSchedule(key);
  requestAnimationFrame(() => {
    schedulePanel.classList.add("is-visible");
  });
};

originSelect.addEventListener("change", handleSelectionChange);
destinationSelect.addEventListener("change", handleSelectionChange);

changeRouteButton.addEventListener("click", () => {
  selectedRoute = null;
  document
    .querySelectorAll(".route-card")
    .forEach((node) => node.classList.remove("is-selected"));
  updateSeatPanel();
  continueButton.disabled = true;
});

seatForm.addEventListener("submit", (event) => {
  event.preventDefault();
  if (!selectedRoute) {
    return;
  }

  continueButton.disabled = true;
  continueButton.textContent = "Procesando...";

  // Simula el paso al flujo de pago existente.
  setTimeout(() => {
    continueButton.textContent = continueButtonLabel;
    continueButton.disabled = false;
    const paymentUrl = seatForm.dataset.paymentUrl || "#pasarela-de-pago";
    window.location.href = paymentUrl;
  }, 800);
});

seatForm.querySelectorAll(".step-button").forEach((button) => {
  button.addEventListener("click", () => {
    const step = Number(button.dataset.step) || 0;
    const current = Number(seatCountInput.value) || 1;
    const nextValue = Math.min(
      Math.max(current + step, Number(seatCountInput.min)),
      Number(seatCountInput.max)
    );
    seatCountInput.value = String(nextValue);
  });
});

seatCountInput.addEventListener("change", () => {
  const value = Number(seatCountInput.value);
  if (!Number.isFinite(value) || value < Number(seatCountInput.min)) {
    seatCountInput.value = seatCountInput.min;
  }
  if (value > Number(seatCountInput.max)) {
    seatCountInput.value = seatCountInput.max;
  }
});

// Permite precargar la UI si hay datos previos desde la sesión.
if (originSelect.value && destinationSelect.value) {
  handleSelectionChange();
}
