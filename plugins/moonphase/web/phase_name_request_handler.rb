module AresMUSH
  module MoonPhase
    class PhaseNameRequestHandler
      def handle(request)
        enactor = request.enactor

        error = Website.check_login(request, true)
        return error if error
        
        {
          phase_name: MoonPhase.phase_name
        }
      end      
    end
  end
end


