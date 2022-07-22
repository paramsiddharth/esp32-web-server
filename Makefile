baud_rate    := 115200
upload_speed := 921600

.PHONY: doit upload update deps pip-deps npm-deps

doit: upload

upload:
	@sed s/SSID_HERE/$(ssid)/ main.js > main-new.js
	@sed s/PSWD_HERE/$(password)/ main-new.js > main-new-2.js
	-@mv main-new-2.js main-new.js
	-espruino -m -p $(port) -b ${baud_rate} -e 'save();' main-new.js
	-@rm main-new.js

burn: deps
	esptool --port $(port) erase_flash
	esptool															\
		--chip esp32												\
		--port $(port)												\
		--baud ${upload_speed}										\
		--after hard_reset write_flash								\
		-z															\
		--flash_mode dio											\
		--flash_freq 40m											\
		--flash_size detect											\
		0x1000 ./espruino_2v14_esp32/bootloader.bin					\
		0x8000 ./espruino_2v14_esp32/partitions_espruino.bin		\
		0x10000 ./espruino_2v14_esp32/espruino_esp32.bin

update: deps
	esptool															\
		--chip esp32												\
		--port $(port)												\
		--baud ${upload_speed}										\
		--before esp32r0											\
		--after hard_reset write_flash								\
		-z															\
		--flash_mode dio											\
		--flash_freq 40m											\
		--flash_size detect											\
		0x10000 ./espruino_2v14_esp32/espruino_esp32.bin

deps: pip-deps npm-deps espruino_2v14_esp32.tgz

pip-deps: pip-deps.done

pip-deps.done:
	pip install esptool
	touch pip-deps.done

npm-deps: npm-deps.done

npm-deps.done:
	npm install -g espruino
	touch npm-deps.done

espruino_2v14_esp32.tgz:
	wget https://www.espruino.com/binaries/travis/af8e933289968020d40fc55b18be8879ac55f085/espruino_2v14_esp32.tgz
	tar -xvzf espruino_2v14_esp32.tgz

serial:
	screen $(port) ${baud_rate}