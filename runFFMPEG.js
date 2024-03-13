"use strict";

async function runFFMPEG(inputFile /* File object https://developer.mozilla.org/en-US/docs/Web/API/File */) { // returns a Uint8Array

var ffmpeg = null;
var tryMultiThread = false; // doesn't seem to work with the service worker method of COORS, or maybe files would need to be hosted locally
const baseURLFFMPEG = 'https://unpkg.com/@ffmpeg/ffmpeg@0.12.6/dist/umd';
const baseURLCore = 'https://unpkg.com/@ffmpeg/core@0.12.3/dist/umd';
const baseURLCoreMT = 'https://unpkg.com/@ffmpeg/core-mt@0.12.3/dist/umd';

const toBlobURLPatched = async (url, mimeType, patcher) => {
	var resp = await fetch(url);
	var body = await resp.text();
	if (patcher) body = patcher(body);
	var blob = new Blob([body], { type: mimeType });
	return URL.createObjectURL(blob);
};

const toBlobURL = async (url, mimeType) => {
	var resp = await fetch(url);
	var body = await resp.blob();
	var blob = new Blob([body], { type: mimeType });
	return URL.createObjectURL(blob);
};

const fetchFile = async (url) => {
	var resp = await fetch(url);
	var buffer = await resp.arrayBuffer();
	return new Uint8Array(buffer);
};

const load = async () => {
	console.log('load started');
	const ffmpegBlobURL = await toBlobURLPatched(`${baseURLFFMPEG}/ffmpeg.js`, 'text/javascript', (js) => js.replace('new URL(e.p+e.u(814),e.b)', 'r.workerLoadURL'));
	await import(ffmpegBlobURL);
	ffmpeg = new FFmpegWASM.FFmpeg();
	ffmpeg.on('log', ({ message }) => {
		console.log(message);
	});
	// check if SharedArrayBuffer is supported via crossOriginIsolated global var
	// https://developer.mozilla.org/en-US/docs/Web/API/crossOriginIsolated
	if (tryMultiThread && window.crossOriginIsolated){
		console.log('Multi thread enabled.');
		await ffmpeg.load({
			workerLoadURL: await toBlobURL(`${baseURLFFMPEG}/814.ffmpeg.js`, 'text/javascript'),
			coreURL: await toBlobURL(`${baseURLCoreMT}/ffmpeg-core.js`, 'text/javascript'),
			wasmURL: await toBlobURL(`${baseURLCoreMT}/ffmpeg-core.wasm`, 'application/wasm'),
			workerURL: await toBlobURL(`${baseURLCoreMT}/ffmpeg-core.worker.js`, 'application/javascript'),
		});
	} else {
		console.log('Single thread enabled.');
		await ffmpeg.load({
			workerLoadURL: await toBlobURL(`${baseURLFFMPEG}/814.ffmpeg.js`, 'text/javascript'),
			coreURL: await toBlobURL(`${baseURLCore}/ffmpeg-core.js`, 'text/javascript'),
			wasmURL: await toBlobURL(`${baseURLCore}/ffmpeg-core.wasm`, 'application/wasm'),
		});
	}
	console.log('ffmpeg.load success');
}

const transcode = async (inputFile) => {
	console.log('transcode started');
	const inputFileName=inputFile.name.replace(/.*\./, 'input.');
	await ffmpeg.writeFile(inputFile.name.replace(/.*\./, 'input.'), new Uint8Array( await inputFile.arrayBuffer() ));
	//await ffmpeg.exec(['-i', 'input.webm', 'output.mp4']);
	await ffmpeg.exec([
		"-i",
		inputFileName,
		"-c:a",
		"pcm_s16le",
		"-ar",
		"44100",
		"-ac",
		"2",
		"output.wav"
	]);
	const data = await ffmpeg.readFile('output.wav');
	console.log('transcode finished');
	return data;
}

await load();
return await transcode(inputFile);

}