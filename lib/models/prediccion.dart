class Prediccion {
    final int golesLocal;
    final int golesVisitante;

    Prediccion({
        required this.golesLocal,
        required this.golesVisitante,
    });

    bool get esEmpate => golesLocal == golesVisitante;

    bool get ganaLocal => golesLocal > golesVisitante;

    bool get ganaVisitante => golesVisitante > golesLocal;
}