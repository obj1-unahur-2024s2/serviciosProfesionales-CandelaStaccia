
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

    var property puedeTrabajar = []

    var property honorarios 

    var recaudacion = 0

    method cobrar(unImporte) {
      recaudacion = recaudacion + unImporte
    }

    method pasarDinero(unProfesional, unImporte) {
      recaudacion = 0.max(recaudacion - unImporte)
      unProfesional.cobrar(unImporte)
    }

    method agregarProvincia(unaProvincia) {
      puedeTrabajar.add(unaProvincia)
    }
}


class Empresa {
    const property profesionales = []
    var property honorariosReferencia
    const property clientes = #{}

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

    method darServicio(unSolicitante) {
      if(self.puedeSatisfacer(unSolicitante)) {
        const unProf = profesionales.find({p => unSolicitante.puedeSerAtendidoPor(p)})
        unProf.cobrar(unProf.honorarios())
        self.agregarCliente(unProf)
      }
    }

    method agregarCliente(unCliente) {
      clientes.add(unCliente)
    }

    method cuantosClientes() = clientes.size()

    method tieneComoClienteA(unSolicitante) {
      return clientes.contains(unSolicitante)
    }

    method esPocoAtractivo(unProfesional) {
      return self.mismasProvinciasQue(unProfesional).any({p => p.honorarios() < unProfesional.honorarios()})
    }//de entre los profesionales que trabajan en la misma provincia que ese profesional, hay alguno que cobre menos?

    method provinciasDe(unProfesional) {
      return unProfesional.puedeTrabajar().asSet()
    }

    method mismasProvinciasQue(unProfesional) {
      return profesionales.filter({p => p.puedeTrabajar().asSet() == self.provinciasDe(unProfesional)})
    }//filtra los profesionales que trabajan en las mismas provincias que ese profesional
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

