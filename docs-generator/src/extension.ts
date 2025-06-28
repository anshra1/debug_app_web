import * as vscode from 'vscode';
import * as fs from 'fs';
import * as path from 'path';

export function activate(context: vscode.ExtensionContext) {
  const disposable = vscode.commands.registerCommand('cleanArchDocs.createOrOpenDocs', async (uri: vscode.Uri) => {
    const workspaceFolder = vscode.workspace.workspaceFolders?.[0].uri.fsPath;
    if (!workspaceFolder) {
      vscode.window.showErrorMessage('No workspace folder found.');
      return;
    }

    const clickedPath = uri.fsPath;
    const libPath = path.join(workspaceFolder, 'lib');

    if (!clickedPath.startsWith(libPath)) {
      vscode.window.showWarningMessage('Only items inside the lib/ folder are supported.');
      return;
    }

    const relativePath = path.relative(libPath, clickedPath);
    const isFile = fs.statSync(clickedPath).isFile();

    let docPath: string;

    if (isFile) {
      // lib/foo/bar.dart → docs/foo/bar.md
      const base = path.basename(relativePath, '.dart');
      const dir = path.dirname(relativePath);
      docPath = path.join(workspaceFolder, 'docs', dir, `${base}.md`);
    } else {
      // lib/foo/bar/ → docs/foo/bar.md
      const folderName = path.basename(clickedPath);
      const dir = path.dirname(relativePath);
      docPath = path.join(workspaceFolder, 'docs', dir, `${folderName}.md`);
    }

    fs.mkdirSync(path.dirname(docPath), { recursive: true });

    if (!fs.existsSync(docPath)) {
      const scaffold = `# 📘 Documentation for \`${relativePath}\`\n\n> Describe this module’s purpose, structure, and business logic here.`;
      fs.writeFileSync(docPath, scaffold);
      vscode.window.showInformationMessage(`📝 Documentation created at: ${path.relative(workspaceFolder, docPath)}`);
    } else {
      vscode.window.showInformationMessage(`📄 Opening existing documentation file.`);
    }

    const doc = await vscode.workspace.openTextDocument(docPath);
    vscode.window.showTextDocument(doc);
  });

  context.subscriptions.push(disposable);
}

export function deactivate() {}
