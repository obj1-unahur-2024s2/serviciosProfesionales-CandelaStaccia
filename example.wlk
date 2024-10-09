
class Universidad {
    const property provincia 

    var property honorarios 
    
    var donaciones = 0

    method recibirDonaciones(unImporte) {
      donaciones = donaciones + unImporte
    }
}


class AsociadoAUniversidad {
    const property universidad

    method honorarios() = universidad.honorarios()

    method puedeTrabajar() = [universidad.provincia()] //una lista para q sea polimorfico

    method cobrar(unImporte) {
      universidad.recibirDonaciones(unImporte / 2)
    }
}


class AsociadoAlLitoral {
    const property universidad

    method honorarios() = 3000

    method puedeTrabajar() = ["Entre Rios", "Santa Fe", "Corrientes"]  

    method cobrar(unImporte) {
      asociacionProfesionalesDelLitoral.recaudar(unImporte)
    }
}

object asociacionProfesionalesDelLitoral {
    var recaudacion = 0

    method recaudar(unImporte) {
      recaudacion = recaudacion + unImporte
    }
}

class Libre {
    const property universidad

    var property puedeTrabajar

    var property honorarios 

    method cobrar(unImporte) {
      
    }
}


class Empresa {
    const property profesionales = []
    var property honorariosReferencia

    method agregarProfesional(unProfesional) {
      profesionales.add(unProfesional)
    }

    method cuantos(unaUniversidad) {
      return profesionales.count({p => p.universidad() == unaUniversidad})
    }

    method caros() {
      return profesionales.filter({p => p.honorarios() > honorariosReferencia})
    }

    method formadoras() {
      return profesionales.map({p => p.universidad()}).asSet()
    }

    method masBarato() {
      return profesionales.min({p => p.honorarios()})
    }

    method esDeGenteAcotada() {
      return not profesionales.any({p => p.puedeTrabajar().size() > 3})
    } //profesionales.all({p => p.puedeTrabajar().size() <= 3})

    method puedeSatisfacer(unSolicitante) {
      return profesionales.any({p => unSolicitante.puedeSerAtendidoPor(p)})
    }
}

////////////////////////////////////////////////////////////////////////////////////

class SolicitantePersona {
    var property provincia

    method puedeSerAtendidoPor(unProfesional) {
      return unProfesional.puedeTrabajar().contains(provincia) //depende del prof
    }
}


class SolicitanteInstitucion {
    var property universidades

    method puedeSerAtendidoPor(unProfesional) {
      return universidades.contains(unProfesional.universidad()) //depende de las unis de la inst
    }
}


class SolicitanteClub {
    var property provincias

    method puedeSerAtendidoPor(unProfesional) {
      return not provincias.asSet().intersection(unProfesional.puedeTrabajar().asSet()).isEmpty()
    } //provincias.any({p => unProfesional.puedeTrabajar().contains(p)}) //o size > 0
}


/////////////////////////////////////////////////////////////////////////

