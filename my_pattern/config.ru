class App
	def call(env)
		p env
		[
				200,
				{ 'Content-type' => 'text/html' },
				[
						'<html>' + env['PATH_INFO'] + '</html>'
				]
		]
	end
end

run App.new